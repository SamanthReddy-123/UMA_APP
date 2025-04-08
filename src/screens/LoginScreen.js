import React from 'react';
import { View, Text, Button } from 'react-native';

const LoginScreen = ({ navigation }) => {
  return (
    <View>
      <Text>Login</Text>
      <Button title="Login" onPress={() => navigation.navigate('Home')} />
      <Button title="Signup" onPress={() => navigation.navigate('Signup')} />
    </View>
  );
};

export default LoginScreen;
