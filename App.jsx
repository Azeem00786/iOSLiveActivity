import React, {useEffect} from 'react';
import {View, Text, Button, StyleSheet, Alert} from 'react-native';
import LiveActivity from './src/LiveActivity';
const App = () => {
  const restaurantName = 'Pizza Palace';
  const orderNumber = '12345';
  const eta = '30 mins';
  const updatedEta = '25 mins';
  const status = 'Order is being prepared';

  const handleStartActivity = async () => {
    try {
      const activityId = await LiveActivity.startActivity(
        restaurantName,
        orderNumber,
        eta,
      );
      Alert.alert('Success', `Activity started with ID: ${activityId}`);
    } catch (error) {
      Alert.alert('Error', `Failed to start activity: ${error.message}`);
      console.log(`Failed to start activity: ${error.message}`);
    }
  };

  const handleUpdateActivity = async () => {
    try {
      const activityId = 'some_activity_id'; // Replace with the actual activity ID
      const result = await LiveActivity.updateActivity(
        activityId,
        updatedEta,
        status,
      );
      Alert.alert('Success', `Activity updated: ${result}`);
    } catch (error) {
      Alert.alert('Error', `Failed to update activity: ${error.message}`);
    }
  };

  const handleEndActivity = async () => {
    try {
      const activityId = 'some_activity_id'; // Replace with the actual activity ID
      const result = await LiveActivity.endActivity(activityId);
      Alert.alert('Success', `Activity ended: ${result}`);
    } catch (error) {
      Alert.alert('Error', `Failed to end activity: ${error.message}`);
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.header}>Live Activity Demo</Text>
      <Button title="Start Activity" onPress={handleStartActivity} />
      <View style={styles.spacer} />
      <Button title="Update Activity" onPress={handleUpdateActivity} />
      <View style={styles.spacer} />
      <Button title="End Activity" onPress={handleEndActivity} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
  },
  header: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  spacer: {
    height: 20,
  },
});

export default App;
