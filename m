Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Carlo Parravicini <c.parravicini@sehitaly.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: ELDK 3.0 C++ Problem
Date: Wed, 19 May 2004 17:57:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405191757.48552.c.parravicini@sehitaly.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

have anybody problems using ELDK3.0 ppc_8xx-g++ cross-compiler(x86) on 'new'
function?
I try to run a stupid program like that on a linux 2.4.4 (previus ELDK 2.1) &
linux 2.4.24 (ELDK 3.0)
//=================================================
#include <iostream>
#include <string.h>
int main (int argc, char **argv)
{
  int *p = new int (10000);
  memset ( p, 0, 10000);
  if (p == NULL)
   std::cout << "Allocation error\n";
  else
   std::cout << "OK.\n";

return 0;
//=================================================

ppc_8xx-g++ =Wall cpp.cpp -o cpp
ldd cpp->
	libstdc++.so.5 => /usr/lib/libstdc++.so.5 (0x0ff12000)
	libm.so.6 => /lib/libm.so.6 (0x0fe46000)
	libc.so.6 => /lib/libc.so.6 (0x0fce7000)
	/lib/ld.so.1 => /lib/ld.so.1 (0x30000000)


Both give me a segmentation fault on 'new' execution


The same using a malloc compiled in 'C' mode runs
Previous version of ELDK works fine

Any other have c++ compiling problems or have compiled c++ code successfuly?




email: carlo@sehitaly.com
http://www.sehitaly.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
