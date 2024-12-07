// Mocks generated by Mockito 5.4.4 from annotations
// in date_ai/test/screens/login_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:date_ai/services/login_service.dart' as _i3;
import 'package:date_ai/utils/api/api_response.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUri_0 extends _i1.SmartFake implements Uri {
  _FakeUri_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeApiResponse_1 extends _i1.SmartFake implements _i2.ApiResponse {
  _FakeApiResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginService extends _i1.Mock implements _i3.LoginService {
  MockLoginService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Uri get url => (super.noSuchMethod(
        Invocation.getter(#url),
        returnValue: _FakeUri_0(
          this,
          Invocation.getter(#url),
        ),
      ) as Uri);

  @override
  _i4.Future<_i2.ApiResponse> execute(Map<String, String>? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [data],
        ),
        returnValue: _i4.Future<_i2.ApiResponse>.value(_FakeApiResponse_1(
          this,
          Invocation.method(
            #execute,
            [data],
          ),
        )),
      ) as _i4.Future<_i2.ApiResponse>);
}