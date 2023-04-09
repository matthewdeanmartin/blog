Title: Creating a useful and funny python serializer
Date: 2023-03-19
Modified: 2023-03-19
Tags: python
Category: python
Slug: python-markpickle-2023
Authors: Matthew Martin
Summary: I wrote a library that serializes and deserializes markdown to and from python, but more in the style of pickle and less in the style of a document object model.

# Hello markpickle

I got the name from ChatGPT.

## Origin Story

I wanted an API to support as many mime types as possible. Some mime types are for the people, such as PDF, Excel/CSV. Some time types are for the machines, like json, bson.

I thought, what about HTML and text? HTML has a problem with XSS risks. Text has a problem of not having much of a standard story for "styled" plaintext. Except for Markdown. Can I use markdown as a mime type for what starts out as a JSON object?

## Challenges

The app is two functions, loads and dumps and they take or return an `Any` type and take or return a string. The `Any` is a problem, because mypy doesn't know how to deal with arbitrarily complex types. It seems to get confused with `Union`s of `Union`s of `Union`s. It gets confused with generics, e.g. lists that can work with any contents.

## Impedance Mismatches

Markdown has some analogies:

- header groupings + paragraphs make dicts, or even nested dicts
- Lists or lists of lists
- tables are dicts, but you can only put scalars in the values. This makes python objects of a certain level of nesting unrepresentable.
- strings and non-string types can be represented, but you can only infer a number should be integer. This blocks round tripping.

Some things are impossible

- empty dictionaries, empty lists exist in python but have no representation in markdown. An empty list is just zero-length whitespace where the list is not. This blocks round tripping.

Python has no use for a lot of markdown formatting, such as bold, or code block or quote. Those things would just be strings and they'd continue to hold markdown in the string.
