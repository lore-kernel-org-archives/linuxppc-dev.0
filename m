Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030711045749.4201.qmail@web40306.mail.yahoo.com>
Date: Thu, 10 Jul 2003 21:57:49 -0700 (PDT)
From: Miku Jha <jha_miku@yahoo.com>
Subject: cross compiling gdb for ppc
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have downloaded gdb version 5.3 and cross compiled
it for target ppc-linux.

When I run the gdb to debug the core file it somehow
refers to the libraries in the /lib path
the libraries for my target machine are somewhere
else.

I wanted to know if there is any option or workaround
to make gdb point to correct libraries.

Also I am not sure if there are some aditional stuff
to be done when cross compiling GDB for power pc


Any help appreciated.

Thanks



=====
mailto:jha_miku@yahoo.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
