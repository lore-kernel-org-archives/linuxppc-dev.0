Message-Id: <199908092006.WAA00321@piglet.cpu.lu>
Date: Mon, 9 Aug 1999 22:06:15 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: trini@disparity.net
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.BSF.3.96.990809145017.16262j-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   9 Aug, this message from Tom Rini echoed through cyberspace:
> On Mon, 9 Aug 1999, Paul Mackerras wrote:
>> There's no problem about enabling both cmd646 and ide-pmac with the
>> current vger sources, is there?  You do need to select experimental
>> drivers as well as "Generic PCI IDE chipset support"
>> (CONFIG_BLK_DEV_IDEPCI) and "Generic PCI bus-master DMA support"
>> (CONFIG_BLK_DEV_IDEDMA) before you get asked about the CMD646, though.
> 
> Right, the problem comes from enabling CMD646 but not ide-pmac.  Right now
> to use any IDE chipset on a pmac, you need to say yes to "Builtin PowerMac
> IDE support" and whichever chipset you have (to boot at least, I'll check
> being able to use it once I can boot off something else, but it sounds
> like there might be a problem there as well).

On my box, the kernel panics on IDE initialization if I don't enable
builtin PowerMac IDE. There's no problem compiling the kernel, though...
and I haven't had time to trace the problems. Might be a missing
function definition (although linker should catch that?) or an
undefined constant? Or the uninitialized ppc_ide_md array?

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
