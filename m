From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200309040558.h845wW900694@hofr.at>
Subject: Re: Memory Profiling Tool
In-Reply-To: <200309021344.IAA18035@lists.linuxppc.org> from "mss59@att.net"
 at "Sep 2, 2003 01:43:55 pm"
To: mss59@att.net
Date: Thu, 4 Sep 2003 07:58:32 +0200 (CEST)
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Is there any memory profiling and leak detection tool available which works
> for both PPC and X86??

bgcc - bounds checking gcc - its a patch to gcc

the output will look something like this but can be tuned with compile time options:

Bounds Checking GCC v gcc-3.2.2-3.1 Copyright (C) 1995 Richard W.M. Jones
Bounds Checking comes with ABSOLUTELY NO WARRANTY. For details see file
`COPYING' that should have come with the source to this program.
Bounds Checking is free software, and you are welcome to redistribute it
under certain conditions. See the file `COPYING' for details.
For more information, set GCC_BOUNDS_OPTS to `-help'
Bounds library call frequency statistics:
  Calls to push, pop, param function:        1, 1, 0
  Calls to add, delete stack:                1, 1
  Calls to add, delete heap:                 1, 0
                                             ^^^^
                                       malloc but no free..

  Calls to check pointer +/- integer:        0
  Calls to check array references:           0
  Calls to check pointer differences:        0
  Calls to check object references:          0
  Calls to check component references:       0
  Calls to check truth, falsity of pointers: 0, 0
  Calls to check <, >, <=, >= of pointers:   0
  Calls to check ==, != of pointers:         0
  Calls to check p++, ++p, p--, --p:         0, 0, 0, 0
  References to unchecked static, stack:     0, 0

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
