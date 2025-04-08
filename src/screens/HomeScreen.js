import React from 'react';
import { View, Text, Button } from 'react-native';

const HomeScreen = ({ navigation }) => {
  return (
    <View>
      <Text>Welcome to UMA - Home</Text>
      <Button title="Go to Player" onPress={() => navigation.navigate('Player')} />
      <Button title="Go to Favorites" onPress={() => navigation.navigate('Favorites')} />
    </View>
  );
};

export default HomeScreen;
