Date: Mon, 17 Jan 2000 16:40:35 -0800 (PST)
From: Sean Chitwood <darkmane@w-link.net>
Reply-To: darkmane@w-link.net
To: Kevin Buettner <kev@primenet.com>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help w/ gdb
In-Reply-To: <1000117223224.ZM16757@saguaro.lan>
Message-ID: <Pine.LNX.4.10.10001171637020.3713-100000@darkmane.w-link.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I'm assuming you mean to change the CFLAGS in the Makefile... correct? I'll do that tonight and hopefully let you know in th emorning....

	Just for my edification, what is the difference between -g and -gdwarf-2... I have a bad feeling one produces elf binaries and one produces dwarf binaries.... Not that I would know the difference...


On Mon, 17 Jan 2000, Kevin Buettner wrote:

> One of the things you might try is to recompile using DWARF2 debugging
> symbols.  Replace -g with -gdwarf-2.
> 
> I'm not necessarily suggesting that you start use dwarf2 debugging
> symbols instead of stabs, but this will tell me more about the
> problem.  (If it works properly with dwarf2, then I have a patch for
> you which should make it behave properly with stabs.)
> 
> Thanks for the feedback.
> 
> Kevin
> 
> 

	Sean aka Darkmane
+------------------------------
+ On October 16, 1999 A.D.
+ Sean Chitwood proudly proclaimed
+ his love for Melissa Webb
+ and made her his lifemate
+------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
