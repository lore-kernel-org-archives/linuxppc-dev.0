Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F2A2CB6.4030104@windriver.com>
Date: Fri, 01 Aug 2003 10:02:46 +0100
From: Richard Danter <richard.danter@windriver.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 750/107 CHRP question
References: <20030801082845.A38F6C602D@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
> In message <3F2A21D5.2040204@windriver.com> you wrote:
>
>>There is a command in the vICE-II called "CF MMU LINUX" which turns on
>>MMU handling (doesn't have to be Linux running) and then you use the
>>MMUA command to set up the mapping (eg MMUA C0000000 0 F0000000) and hey
>>presto!
>
> Will this work just for code statically linked with  the  kernel,  or
> also  for  dynamically  loaded  modules?  How about accessing dynamic
> variables on the stack?
>
> My understanding is that more than just a static  mapping  is  needed
> for full MMUP support.

You are correct. Only the kernel and drivers statically linked can be
easily debugged. It could be possible to debug modules but since the
addresses change every time you load them it would not be practical. You
would have to edit the symbol files (*.ab) each time.

For complete MMU handling the debugger would need to know where to find
the mapping tables and remap it's symbol info. None of our debuggers can
do that yet.

Rich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
