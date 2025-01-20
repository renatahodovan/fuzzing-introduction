try {
    throw new Error('Something went wrong');
  } catch (e) {
    console.error(e.message);
  }
  