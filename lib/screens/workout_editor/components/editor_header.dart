// Copyright Miroslav Mazel et al.
//
// This file is part of Feeel.
//
// Feeel is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// As an additional permission under section 7, you are allowed to distribute
// the software through an app store, even if that store has restrictive terms
// and conditions that are incompatible with the AGPL, provided that the source
// is also available under the AGPL with or without this permission through a
// channel without those restrictive terms and conditions.
//
// As a limitation under section 7, all unofficial builds and forks of the app
// must be clearly labeled as unofficial in the app's name (e.g. "Feeel
// UNOFFICIAL", never just "Feeel") or use a different name altogether.
// If any code changes are made, the fork should use a completely different name
// and app icon. All unofficial builds and forks MUST use a different
// application ID, in order to not conflict with a potential official release.
//
// Feeel is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with Feeel.  If not, see <http://www.gnu.org/licenses/>.

import 'package:feeel/theming/feeel_shade.dart';
import 'package:feeel/theming/feeel_swatch.dart';
import 'package:flutter/material.dart';

class EditorHeader extends StatelessWidget {
  final Function() onClose;
  final Function(String? title) saveState;
  final FeeelSwatch colorSwatch;
  final String hintText;
  final String emptyError;
  final TextEditingController textEditingController;

  const EditorHeader(
      {Key? key,
      required this.onClose,
      required this.saveState,
      required this.colorSwatch,
      required this.hintText,
      required this.emptyError,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        colorSwatch.getColor(FeeelShade.dark.invertIfDark(theme.brightness));
    return Row(children: <Widget>[
      const SizedBox(
        width: 4,
      ),
      CloseButton(
        onPressed: onClose,
        color: colorSwatch
            .getColor(FeeelShade.dark.invertIfDark(theme.brightness)),
      ),
      Expanded(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              style: theme.appBarTheme.titleTextStyle?.copyWith(color: color),
              controller: textEditingController,
              decoration: InputDecoration(
                  focusColor: color,
                  hintStyle: theme.appBarTheme.titleTextStyle?.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? colorSwatch.getColor(FeeelShade.darkest)
                          : colorSwatch.getColor(FeeelShade.lighter)),
                  filled: false,
                  hintText: hintText),
              validator: (String? input) {
                if (input == null || input.isEmpty) {
                  return emptyError;
                }
                return null;
              },
              onChanged: saveState,
              onSaved: saveState,
            )),
      ),
    ]);
  }
}