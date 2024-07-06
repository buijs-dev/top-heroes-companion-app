// Copyright (c) 2021 - 2024 Buijs Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import 'package:flutter/material.dart';

import '../../theme.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({required this.onSearch, super.key});

  @override
  State<SearchCard> createState() => _SearchCardState();

  final void Function(String) onSearch;
}

class _SearchCardState extends State<SearchCard> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelMedium;
    return TextField(
      style: textStyle?.copyWith(color: appBarTextColor),
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      onChanged: widget.onSearch,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: appBarTextColor.withOpacity(0.4),
        ),
        hintText: "Search",
        hintStyle: textStyle?.copyWith(
          color: appBarTextColor.withOpacity(0.4),
        ),
        border: InputBorder.none,
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
            widget.onSearch("");
          },
          icon: Icon(
            Icons.clear,
            color: appBarTextColor.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
