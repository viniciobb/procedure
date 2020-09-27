const functions = require('firebase-functions');
const { error } = require('firebase-functions/lib/logger');
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();


 // Create and Deploy Your First Cloud Functions
 // https://firebase.google.com/docs/functions/write-firebase-functions
 // https://us-central1-procedure-289419.cloudfunctions.net/helloWorld

 exports.getBHWeather = functions.https.onRequest((request, response) => {

        const docRef = db.doc('cities/BJ');
        const promise = docRef.get();
        console.log('entrou teste novo');
        const p2 = promise.then(snapshot=>{

          if(!snapshot.exists)
            return response.status(200).send("undefined");
          else
            return response.status(200).send(snapshot.data());  
        });
        p2.catch(error=>{
          console.log(error);
          return response.status(500).send(error);
        });
        
 });

 