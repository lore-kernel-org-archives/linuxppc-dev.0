From: Wolfgang Haeuptli <whaeuptli@bluewin.ch>
To: linuxppc-dev@lists.linuxppc.org
Subject: compile-error: stdin is not a constant
Date: Wed, 3 Nov 1999 13:25:44 +0100
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99110313351500.00438@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello people

sorry for the (probably) basic question...

Since I installed R5, some programs (that used to compile OK on R4) 
complain about : 

initializer element for 'foo' is not constant

while compiling constructs like:

FILE *foo = stdin;   (or FILE *foo = {(FILE *) stdin};  )

when I replaced this line with: FILE *foo = STDIN_FILENO; 
( defined in unistd.h), compilation works, but the resulting program
segfaults...

Any hints to make this work would be very much appreciated.

Wolfgang Haeuptli
  

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
