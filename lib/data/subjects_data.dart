class SubjectData {
  final String name;
  final String icon;
  final int color;
  final int lightColor;
  final List<String> topics;
  final List<String> experiments;
  final List<String> disclaimers;

  const SubjectData({
    required this.name,
    required this.icon,
    required this.color,
    required this.lightColor,
    required this.topics,
    required this.experiments,
    required this.disclaimers,
  });
}

class AppData {
  static const List<SubjectData> academicSubjects = [
    SubjectData(
      name: 'Physics',
      icon: '⚛️',
      color: 0xFF6C3FF5,
      lightColor: 0xFFEDE8FF,
      topics: [
        'What is Force?',
        'Light & Reflection',
        'Electricity Basics',
        'Sound Waves',
        'Gravity & Motion',
        'Energy & Its Types',
        'Magnetism',
        'Heat & Temperature',
      ],
      experiments: [
        'Roll a ball down a ramp and measure how far it goes',
        'Shine a torch at a mirror and trace the reflection',
        'Build a simple circuit with a battery and bulb',
        'Clap near a wall and listen for the echo',
        'Drop a heavy and light object from the same height',
        'Stretch a rubber band — where is the energy stored?',
        'Use a magnet to find magnetic objects around the house',
        'Feel a metal spoon vs a wooden spoon after leaving in hot water',
      ],
      disclaimers: [
        '⚠️ Always ask an adult before doing electricity experiments.',
        '⚠️ Never look directly at bright light sources.',
        '⚠️ Adult supervision needed for hot water experiments.',
      ],
    ),
    SubjectData(
      name: 'Mathematics',
      icon: '📐',
      color: 0xFF3B8BFF,
      lightColor: 0xFFE0EEFF,
      topics: [
        'Numbers & Place Value',
        'Fractions Made Easy',
        'Introduction to Algebra',
        'Geometry & Shapes',
        'Probability Basics',
        'Ratios & Proportions',
        'Decimals & Percentages',
        'Area & Perimeter',
      ],
      experiments: [
        'Count objects in your room and group them by tens',
        'Cut a pizza or sandwich into equal parts',
        'Find the mystery number: x + 5 = 12',
        'Draw shapes and measure all their angles',
        'Flip a coin 20 times and record heads vs tails',
        'Compare two recipes and double or halve the ingredients',
        'Calculate 20% off a price tag in a shop',
        'Measure the area of your bedroom floor',
      ],
      disclaimers: [
        '✏️ Always show your working — it helps you find mistakes!',
        '📏 Use a ruler for accurate geometry work.',
      ],
    ),
    SubjectData(
      name: 'Biology',
      icon: '🌿',
      color: 0xFF34C759,
      lightColor: 0xFFDFFAEB,
      topics: [
        'Cells — The Building Blocks',
        'Human Body Systems',
        'Plants & Photosynthesis',
        'Food Chains & Ecosystems',
        'The Human Skeleton',
        'DNA & Genetics Basics',
        'Microorganisms',
        'Evolution in Simple Terms',
      ],
      experiments: [
        'Look at an onion skin under a magnifying glass',
        'Draw and label a human body diagram',
        'Grow a bean sprout in a cup with damp cotton wool',
        'Draw a garden food chain from grass to fox',
        'Feel your own bones — wrist, knee, spine',
        'Extract DNA from a strawberry using washing up liquid',
        'Grow bread mold in a sealed bag (do not open!)',
        'Compare your hand to a family member — spot the differences',
      ],
      disclaimers: [
        '⚠️ Never open mold experiments — spores can be harmful.',
        '🧤 Wash hands thoroughly after any biology experiment.',
        '⚠️ Adult supervision needed for kitchen experiments.',
      ],
    ),
    SubjectData(
      name: 'Chemistry',
      icon: '🧪',
      color: 0xFFFF6B6B,
      lightColor: 0xFFFFE8E8,
      topics: [
        'What Are Atoms & Molecules?',
        'Elements & The Periodic Table',
        'Acids & Bases',
        'Chemical Reactions',
        'States of Matter',
        'Mixtures & Solutions',
        'Combustion & Burning',
        'Metals & Non-Metals',
      ],
      experiments: [
        'Build an atom model using clay and cocktail sticks',
        'Find 5 elements mentioned on household products',
        'Test lemon juice, milk and water with litmus paper',
        'Mix baking soda and vinegar — watch it fizz!',
        'Observe water as ice, liquid and steam',
        'Dissolve salt in water, then let it evaporate',
        'Light a candle and observe combustion safely',
        'Test which objects a magnet attracts',
      ],
      disclaimers: [
        '🔥 Never do fire experiments without an adult present.',
        '⚠️ Never mix chemicals unless told it is safe.',
        '🧤 Use gloves when handling acids or bases.',
      ],
    ),
    SubjectData(
      name: 'Computing & Python',
      icon: '💻',
      color: 0xFFFF5EAB,
      lightColor: 0xFFFFE0F2,
      topics: [
        'What Is a Computer?',
        'Data Types — What & Why',
        'Variables & How to Use Them',
        'Loops — Making Computers Repeat',
        'If/Else — Making Decisions',
        'Functions — Reusable Code',
        'Lists & Arrays',
        'Your First Mini Project',
      ],
      experiments: [
        'Identify CPU, RAM and storage in your device settings',
        'Print your name, age and favourite colour in Python',
        'Store your name in a variable and print a greeting',
        'Make Python count from 1 to 100 using a loop',
        'Write a number guessing game using if/else',
        'Write a function that adds two numbers together',
        'Create a shopping list using a Python list',
        'Build a simple quiz with 3 questions in Python',
      ],
      disclaimers: [
        '💻 Install Python free at python.org — it works offline!',
        '🔒 Never share personal information in code you upload online.',
      ],
    ),
    SubjectData(
      name: 'English & Literacy',
      icon: '📚',
      color: 0xFFFFB830,
      lightColor: 0xFFFFF4D6,
      topics: [
        'Reading for Understanding',
        'Writing Great Sentences',
        'Paragraphs & Structure',
        'Punctuation & Grammar',
        'Creative Writing',
        'Persuasive Writing',
        'Poetry & Rhythm',
        'Summarising & Note-taking',
      ],
      experiments: [
        'Read a page of any book and summarise it in 3 sentences',
        'Write 5 sentences using 5 different sentence starters',
        'Write a paragraph about your best day ever',
        'Find 10 punctuation marks in a newspaper or book',
        'Write a short story that starts with "The door opened slowly..."',
        'Write a short speech persuading someone to try your hobby',
        'Write a poem about your country using 5 senses',
        'Read an article and pull out the 3 main points',
      ],
      disclaimers: [
        '📖 Reading every day — even 10 minutes — makes a huge difference!',
      ],
    ),
  ];

  static const List<SubjectData> nonAcademicSubjects = [
    SubjectData(
      name: 'Creative Arts',
      icon: '🎨',
      color: 0xFFFFB830,
      lightColor: 0xFFFFF4D6,
      topics: [
        'Colour Theory Basics',
        'Drawing from Observation',
        'Music & Rhythm',
        'Photography Composition',
        'Digital Art Introduction',
        'Storytelling & Scripts',
        'Clay & Sculpture',
        'Collage & Mixed Media',
      ],
      experiments: [
        'Mix red, blue and yellow paint — what colours do you make?',
        'Draw your own hand exactly as you see it',
        'Clap a rhythm and get someone to copy it',
        'Take 5 photos using the rule of thirds',
        'Draw a landscape digitally on your phone or tablet',
        'Write the first scene of your own short film',
        'Make an animal from air-dry clay or playdough',
        'Make a collage using old magazines and newspapers',
      ],
      disclaimers: [
        '🎨 There are no mistakes in art — only experiments!',
        '✂️ Ask an adult when using scissors or craft knives.',
      ],
    ),
    SubjectData(
      name: 'Life Skills',
      icon: '🌟',
      color: 0xFF0EC4A0,
      lightColor: 0xFFD8FBF4,
      topics: [
        'Managing Your Time',
        'Basic Cooking Skills',
        'Budgeting & Pocket Money',
        'Reading Maps & Navigation',
        'First Aid Basics',
        'Healthy Habits & Sleep',
        'Communication Skills',
        'Problem Solving',
      ],
      experiments: [
        'Plan every hour of tomorrow before you go to sleep',
        'Cook a simple breakfast by yourself — toast, cereal or eggs',
        'Track every penny you spend for 3 days',
        'Navigate to a local place using a map app — no autocomplete!',
        'Learn and practise the recovery position',
        'Track your sleep time for one week',
        'Have a conversation without using your phone for 15 minutes',
        'Fix something small that is broken around the house',
      ],
      disclaimers: [
        '🍳 Always ask an adult before using the cooker or oven.',
        '🚗 Never navigate alone in unfamiliar areas.',
        '🏥 First aid knowledge is valuable — consider a real course too!',
      ],
    ),
    SubjectData(
      name: 'Coding for Fun',
      icon: '🎮',
      color: 0xFF6C3FF5,
      lightColor: 0xFFEDE8FF,
      topics: [
        'Scratch — Drag & Drop Coding',
        'Make a Character Move',
        'Add Sound & Music',
        'Build a Simple Game',
        'Animations & Sprites',
        'Make a Quiz in Scratch',
        'Introduction to HTML',
        'Your Own Mini Website',
      ],
      experiments: [
        'Go to scratch.mit.edu and make a cat walk across the screen',
        'Add arrow key controls to move your sprite',
        'Record your own voice and add it to your project',
        'Build a simple catch-the-falling-object game',
        'Create a 3-frame animation of a bouncing ball',
        'Build a 5-question quiz game in Scratch',
        'Write "Hello World" in HTML and open it in a browser',
        'Make a webpage about your favourite topic',
      ],
      disclaimers: [
        '🔒 Scratch is free and safe — scratch.mit.edu',
        '💻 HTML files work offline — no internet needed!',
      ],
    ),
  ];

  static const List<String> countries = [
    'United Kingdom', 'India', 'Japan', 'USA', 'Pakistan',
    'Nigeria', 'Bangladesh', 'Germany', 'Canada', 'Australia',
    'South Africa', 'Kenya', 'Brazil', 'France', 'UAE', 'Other'
  ];

  static const List<String> scheduleTypes = [
    'learn', 'practice', 'learn', 'practice', 'rest', 'absent-check', 'review'
  ];

  static const List<String> scheduleLabels = [
    '🎬 Watch 2 videos today',
    '✏️ Practice what you learned',
    '🎬 Watch 3 videos today',
    '✏️ Deeper practice session',
    '😴 Rest day — well deserved!',
    '👋 Check-in day',
    '🔁 Quick review session',
  ];
}
