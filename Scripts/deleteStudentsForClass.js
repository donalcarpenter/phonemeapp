var Parse = require('parse/node').Parse;

Parse.initialize('K3q5rEF77YvUaxzFkuxrJKaHfYeq14nJdOMmFdn1', 'cXo3ML1Zz1HNAUSaNtEfWhZSTq9CYUcilC46Pvbr');

var Student = new Parse.Object.extend('student');
var Class = new Parse.Object.extend('class');
var Results = new Parse.Object.extend('rawResults');

// classId L3RCpfByGz

if(process.argv.length < 3){
	console.log('no class id provided');
	return;
}

var classId = process.argv[2]

// loop though all students in 
var qry = new Parse.Query(Student);
qry.equalTo('classId', classId);

qry.find({
	success: function(students){

		for(var i = 0; i < students.length; i++){

			var s = students[i];
			console.log(s.id);

			// delete the results
			var resultsQry = new Parse.Query(Results);
			resultsQry.equalTo('student', s)

			console.log('getting results for student ' + s.id);

			resultsQry.find({
				success: function(results){
					console.log('found ' + 	results.length + ' results for student ' + s.id);
					for(var k = 0; k < results.length; k++)
					{
						var r = results[k]
						console.log('destroy result ' + r.id);
					}
				}, 
				error: function(err){
					console.error('couldn\'t delete result' + err);
				}
			})

			console.log('now destroy student ' + s.id);

			console.log('now destroy class ' + classId);
			
		}
	},
	error: function(err){
		console.log('no class found ' + err);
	}
})

