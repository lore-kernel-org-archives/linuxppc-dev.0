Message-Id: <199908082101.XAA03061@piglet.cpu.lu>
Date: Sun, 8 Aug 1999 23:01:09 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: trini@disparity.net
cc: hedrick@Astro.Dyer.Vanderbilt.Edu, drow@false.org, mj@ucw.cz,
        Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.BSF.3.96.990808165209.16262c-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   8 Aug, this message from Tom Rini echoed through cyberspace:
> On Sun, 8 Aug 1999, Michel Lanners wrote:
[snip'ed about PMac IDE stuff]
> Would this be one of the things solved/cleaned up by seperating ide-pmac.c
> and the CONFIG option for it into generic enable IDE stuff and a driver
> for the builtin IDE on some machines?  Last I tried, I needed to enable
> both cmd646 and ide-pmac on myy blue&white (trying to do this is on my
> todo list, someplace.. :))

I hope so ;-). Not that I'm complaining, but <asm-ppc/ide.h> looks like
quite a mess to me....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
