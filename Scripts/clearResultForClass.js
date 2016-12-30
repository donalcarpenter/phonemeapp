var Parse = require('parse/node').Parse;

Parse.initialize('K3q5rEF77YvUaxzFkuxrJKaHfYeq14nJdOMmFdn1', 'cXo3ML1Zz1HNAUSaNtEfWhZSTq9CYUcilC46Pvbr');

var Student = new Parse.Object.extend('student');
var Class = new Parse.Object.extend('class');
var Results = new Parse.Object.extend('rawResults');

// classId L3RCpfByGz

if(process.argv.length < 4){
	console.log('no class id or task provided');
	return;
}

var classId = process.argv[2];
var task = process.argv[3];

// loop though all students in 
var qry = new Parse.Query(Student);
qry.equalTo('classId', classId);

qry.find({
	success: function(students){

		for(var i = 0; i < students.length; i++){
			
			(function(s){
			console.log(s.id);

			// delete the results
			var resultsQry = new Parse.Query(Results);
			resultsQry.equalTo('student', s);
			resultsQry.equalTo('task', task);

			console.log('getting results for student ' + s.id);

			resultsQry.find({
				success: function(results){
					console.log('found ' + 	results.length + ' results for student ' + s.id);
					for(var k = 0; k < results.length; k++)
					{
						(function(r, s1){
							r.destroy({	
								success: function(o){
									console.log('destroyed result ' + r.id);
								},
								error: function(o, e){
									console.log('couldn\'t destroy destroyed result ' + r.id + '\n' + e);
								}
							});
						}
						)(results[k], s)						
					}
					
					console.log("task " + task + " cleared for student " + s.id);
					s.unset(task);
					s.save();
				}, 
				error: function(err){
					console.error('couldn\'t delete result' + err);
				}
			});
			})(students[i]);			
		}
	},
	error: function(err){
		console.log('no class found ' + err);
	}
});
