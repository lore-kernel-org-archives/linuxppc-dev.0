From: "Thomas C. Allison" <allison@dirac.nist.gov>
Message-Id: <199905192019.QAA00884@dirac.nist.gov>
Subject: possible egcs c compiler bug
To: linuxppc-user@lists.linuxppc.org
Date: Wed, 19 May 1999 16:19:17 -0400 (EDT)
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have found what *appears* to be a bug in the C compiler.  I have experienced
this bug in R4 (regardless of the compiler/library installed) as well as in
the latest (i.e. all the latest packages through 5/15/1999) pre-R5
installation.  I include a short program below which illustrates the problem
I am having.  The code compiles without error on my i386 machine
running RHL 5.2.  The version of EGCS on the PC is 1.0.3 versus 1.1.2 on my
PowerMac, so I don't know if this is a PPC problem or an EGCS problem.
Any input is greatly appreciated.

The code is as follows:

test.c:

     #include <stdio.h>
     #include <stdarg.h>

     static int myFunction(va_list inList)
     {
        va_list newList;
        newList = inList;
     }

When I try to compile the code

     % gcc -c test.c

I get the following error message

     test.c: In function `myFunction':
     test.c:7: incompatible types in assignment

Any ideas?

Thanks in advance,

Tom

+------------------------------------------------------------------------------+
| Dr. Thomas C. Allison                          | thomas.allison@nist.gov     |
| Computational Chemistry Group                  | (301)975-2216 (voice)       |
| National Institute of Standards and Technology | (301)869-4020 (fax)         |
| 100 Bureau Drive, Stop 8380                    |                             |
| Gaithersburg, Maryland 20899-8380              |                             |
+------------------------------------------------------------------------------+
  Chemistry is applied theology.  --- Augustus Stanley Owsley III

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
