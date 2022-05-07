import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_perfect/home/data/pet.dart';
import 'package:pet_perfect/home/presentation/bloc/home_bloc.dart';
import 'package:pet_perfect/home/repositories/pet_repository.dart';

class MockPetRepository extends Mock implements PetRepository {}

void main() {
  late MockPetRepository mockPetRepository;

  setUpAll(() {
    mockPetRepository = MockPetRepository();
  });

  group('Home Bloc Tests', () {
    final petFromRepository = Pet(imageUrl: 'https://random.dog/woof.jpg');

    blocTest<HomeBloc, HomeState>(
      'should emit [PetLoading], [PetLoaded] when [FetchPetEvent] is added',
      build: () {
        when(() => mockPetRepository.getPet())
            .thenAnswer((_) async => petFromRepository);

        return HomeBloc(petRepository: mockPetRepository);
      },
      act: (bloc) => bloc.add(FetchPetEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [PetLoading(), PetLoaded(pet: petFromRepository)],
    );

    blocTest<HomeBloc, HomeState>(
      'should emit [PetSaved], [PetLoaded] when [SavePetEvent] is added',
      build: () {
        when(() =>
                mockPetRepository.saveImageToLocalDatabase(petFromRepository))
            .thenAnswer((_) => Future.value());
        return HomeBloc(petRepository: mockPetRepository);
      },
      act: (bloc) => bloc.add(SavePetEvent(pet: petFromRepository)),
      wait: const Duration(milliseconds: 500),
      expect: () => [PetSaved(), PetLoaded(pet: petFromRepository)],
    );
  });
}
