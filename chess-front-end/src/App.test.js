import React from 'react';
import { render, waitFor, screen } from '@testing-library/react';
import axios from 'axios';
import App from './App';

// Mock the axios post method
jest.mock('axios');

describe('App', () => {
  test('renders loading spinner initially and then renders content', async () => {
    // Mock the axios post response
    const mockResponse = {
      data: {
        isValid: true,
        id: 1,
        username: 'testuser',
        rating: 5,
      },
    };
    axios.post.mockResolvedValue(mockResponse);

    // Render the App component
    render(<App />);

    // Check if the loading spinner is rendered initially
    expect(screen.getByTestId('spinner')).toBeInTheDocument();

    // Wait for the async useEffect function to complete
    await waitFor(() => expect(axios.post).toHaveBeenCalledTimes(1));

    // Check if the content is rendered after loading
    expect(screen.getByText('Chess')).toBeInTheDocument();
    expect(screen.getByText('Create Room')).toBeInTheDocument();

    // You can continue with more assertions for other components and routes
  });
});
