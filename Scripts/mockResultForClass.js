var Parse = require('parse/node').Parse;

Parse.initialize('K3q5rEF77YvUaxzFkuxrJKaHfYeq14nJdOMmFdn1', 'cXo3ML1Zz1HNAUSaNtEfWhZSTq9CYUcilC46Pvbr');

var Student = new Parse.Object.extend('student');
var Class = new Parse.Object.extend('class');
var Results = new Parse.Object.extend('rawResults');

// classId L3RCpfByGz

if(process.argv.length < 4){
	console.log('no class id & task provided');
	return;
}

var classId = process.argv[2]
var task = process.argv[3]

// loop though all students in 
var qry = new Parse.Query(Student);
qry.equalTo('classId', classId);

qry.find({
	success: function(students){

		console.log('There are ' + students.length + ' students in class ' + classId);

		for(var j = 0; j < students.length; j++){

			(function(i){

			var s = students[i];
			console.log('Student ' + s.id + ' found');

			var predicate = new Parse.Query(Results);
		
			predicate.equalTo('student', s)
			predicate.equalTo('task', task)

			predicate.count({
				success: function(instances){
					console.log(instances + ' results for task ' + task + ' for student ' + s.id);

					if(instances == 0){
						// mock the row in the  results
						var r = new Results();
						r.set('task', task);
						r.set('student', s);
						r.save(null, {success: function(s1){

							// mock the column with -1 on the student
							s.set(task, -1);
							s.save(null, {success: function(s1){
								console.log('task ' + task + ' has been mocked for student ' + s.id);
							}, error: function(e){console.log('error2 ' + e);}})
						},
						error: function(e){
							console.log('error1 ' + e);
						}});

					}else{
						console.log('student  ' + s.id + ' already had this task')
					}
				},
				error: function(results){
					console.log('error, count was not good');
				}
			})
		})(j);
	}
	},
	error: function(err){
		console.log('no class found ' + err);
	}
})

