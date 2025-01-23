import {NativeModules} from 'react-native';

const {LiveActivityBridge} = NativeModules;

export default {
  startActivity: (restaurantName, orderNumber, eta) => {
    return new Promise((resolve, reject) => {
      LiveActivityBridge.startActivity(
        restaurantName,
        orderNumber,
        eta,
        (error, activityId) => {
          if (error) {
            reject(error);
          } else {
            resolve(activityId);
          }
        },
      );
    });
  },

  updateActivity: (activityId, eta, status) => {
    return new Promise((resolve, reject) => {
      LiveActivityBridge.updateActivity(
        activityId,
        eta,
        status,
        (error, result) => {
          if (error) {
            reject(error);
          } else {
            resolve(result);
          }
        },
      );
    });
  },

  endActivity: activityId => {
    return new Promise((resolve, reject) => {
      LiveActivityBridge.endActivity(activityId, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  },
};
