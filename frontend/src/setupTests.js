import '@testing-library/jest-dom';

if (typeof setImmediate === 'undefined') {
  global.setImmediate = (callback, ...args) => {
    const timer = setTimeout(callback, 0, ...args);
    return {
      clear: () => clearTimeout(timer),
    };
  };
}

if (typeof clearImmediate === 'undefined') {
  global.clearImmediate = (timer) => timer.clear();
}
