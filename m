Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <23327.216.110.51.8.1071158800.squirrel@www.orkun.us>
In-Reply-To: <3FD80C23.4040003@kegel.com>
References: <6F8DFFA2C996D711945800065BFC9E4A0380A08C@il02exm11>
    <3FD80C23.4040003@kegel.com>
Date: Thu, 11 Dec 2003 10:06:40 -0600 (CST)
Subject: Re: Cross-compile package combinations
From: "listmember@orkun.us" <listmember@orkun.us>
To: linuxppc-embedded@lists.linuxppc.org
Cc: "Dan Kegel" <dank@kegel.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Silverton Aron-C1710C wrote:
>> Hello all,
>>
>> Can somebody give me a clue as to which versions of binutils, gcc, and
>> glibc are compatible with each other?  I'd like to use gcc 3.2 or 3.3
>> and I am developing on i386 targeting PowerPC.  I'll be using 2.4
>> kernels initially and then moving to 2.6.
>>
>> If there is a known reference or recent previous post (I didn't see one
>> in my initial search) I'd appreciate a pointer.
>
> As Ashwin mentioned, http://kegel.com/crosstool might come in handy.
> See also the matrix at http://embeddedtux.org.
> - Dan

Funny, I was just about to ask  very similar question. I will be working
an a IBM PPC405G based development board (Cogent CSB272) for an internal
project. I would like to use as up-to-date versions of GCC, GLIBC and
Linux 2.4 kernel as possible (without sacrificing stability).

- Has anyone used recently released 2.4.23 (kernel.org) in any PPC project
yet? If it is not good to use for PPC based development? Do I need to get
a ppc specific modified kernel or do I need to apply any patches to linus
2.4.23 kernel to get it working in PPC405 embedded environment.

- Kernel 2.4.x README still says the official kernel compiler is gcc
2.95.3. Is it still the case or using a more recent GCC compiler is now
acceptable? In the last Linux embedded project I was in we had used this
one along with a very early build of kernel. I was not the one to set the
development environment so bear with me if these sound basic questions to
you.

- I built a toolchain using crosstools based on gcc 3.3.2, glibc 2.3.2 and
binutils 2.14.90.0.5. Crosstools default .dat files pull kernel 2.4.21 but
I also got the tools compiled using 2.4.23 sources. I have not tested them
yet since I don't have the board yet? Any comments regarding this
combination?

Looking at some ppc linux distros (not necessarily embedded):

YDL 3.0: kernel 2.4.20, gcc ? glibc 2.3.1, binutils ?
Mandrake: kernel 2.3.21, gcc 3.2.2, glibc, 2.3.1, binutils ?
Gentoo: kernel 2.4.22, gcc ? glibc 2.3.2?, binutils ?

Tolunay

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
