def get_person():
    return {
        'name': 'Lusayo',
        'age': 26,
    }

person = get_person()
name, age = person['name'], person['age']

print(name, age)