part of 'get_information_cubit.dart';

class GetInformationState extends Equatable {
  //Requerimos la variable constructor que es de tipo Lista con datos de tipo Widget
  final List<Widget> constructor;
  const GetInformationState({required this.constructor});

  //Ponemos la variable que vamos a recibir aqui para especificar que esta es la información que queremos que se emita.
  @override
  List<Object> get props => [constructor];
}
