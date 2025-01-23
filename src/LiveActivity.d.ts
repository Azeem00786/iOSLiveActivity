declare module './LiveActivity' {
  const LiveActivity: {
    startActivity: (
      restaurantName: string,
      orderNumber: string,
      eta: string
    ) => Promise<string>;
    
    updateActivity: (
      activityId: string,
      eta: string,
      status: string
    ) => Promise<string>;
    
    endActivity: (
      activityId: string
    ) => Promise<string>;
  };

  export default LiveActivity;
}
