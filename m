Date: Sun, 8 Aug 1999 16:55:01 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
To: Michel Lanners <mlan@cpu.lu>
cc: hedrick@Astro.Dyer.Vanderbilt.Edu, drow@false.org, mj@ucw.cz,
        Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <199908081954.VAA02923@piglet.cpu.lu>
Message-ID: <Pine.BSF.3.96.990808165209.16262c-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 8 Aug 1999, Michel Lanners wrote:

> This fact was already catered for with the definition of outb/inb and
> friends, which get an offset added to the port. Unfortunately, the
> PowerMac IDE code undoes this and replaces it with a different
> mechanism, which in essence removes the offset. Grrr..
>
> I've solved the problem by adding the right offset directly to the
> io-port values as found in the kernel's PCI structures. I think this
> needs more serious rework, though. Paul, are you the author of the
> PowerMac IDE stuff? So we can work this out... 

Would this be one of the things solved/cleaned up by seperating ide-pmac.c
and the CONFIG option for it into generic enable IDE stuff and a driver
for the builtin IDE on some machines?  Last I tried, I needed to enable
both cmd646 and ide-pmac on myy blue&white (trying to do this is on my
todo list, someplace.. :))

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
