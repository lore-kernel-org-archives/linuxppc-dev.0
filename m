Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <005601c3b275$39446fd0$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Ramdisk trivial question
Date: Mon, 24 Nov 2003 11:25:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear friends,

in our project we have always used the NFS to run linux over an 8260 custom
board. Now since the activity is almost stable we have tried to build the
root filesystem on ramdisk. Obviously we have followed all the main rules
which are contained into several good books, but an important choice is
always left to the user: " what are the components of filesystem?". The
answer to this of course depend on several factors which are not the scope
of this e-mail.

The question is: The ELDK 2.01 package (which is currently being used in our
system) is too large to be fitted into a ramdisk, while the minimum
filesystem does not allow to be used in our midrange application. Does
anybody have or can indicate where can we find an almost complete filesystem
scheme (for instance based on the ELDK packages)?

Any help would be apreciated

Many thanks

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
