Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <791B3205DB661A42B4BFE5464A7D1D02010E44F3@chzugexch02.zug.ch.abatos.com>
From: Graf Alex <alex.graf@siemens.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: parse error before `{', stray '\' in program
Date: Thu, 10 Apr 2003 11:23:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

If I have some defines which have '\' inside ...

#define BIND_DESC_ALM \
{ \
	CAlmSourceProp::IdxBindingGrp; \
}

my cross compiler produce following output:

ppc_8xx-gcc -fPIC -DPIC -D_DEBUG -Wall -ansi -g3 -O0
-I/home/projects/Nscu/_Inc -I/home/projects/Nscu/_Inc_PC -c -o main.o
main.cpp
main.cpp:15: parse error before `{'
main.cpp:15: stray '\' in program
main.cpp:16: stray '\' in program

I have have SuSE 8.1 and the cross compiler (ppc_8xx-gcc) has version
2.95.4.

The troubles are coming from the dos <cr><lf> at line end. With gcc 3.2
(from host) I don't have this problems.
I don't want to remove the <cr>s (dos2unix), because these files have to be
used on Windows too.

Any suggestions? Unfortunately there is no ppc_8xx-gcc with version 3.2 out.
Or is it?

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
