Message-Id: <200007102217.AAA00852@piglet.grunz.lu>
Date: Tue, 11 Jul 2000 00:17:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying to enable backside on a G4
To: bh40@calva.net
cc: guillaume.laures@noos.fr, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000709203437.29766@192.168.1.10>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   9 Jul, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>I'm just unsure of the behaviour of :
>>while test 1 = $((`cat /proc/sys/kernel/l2cr | awk -F : '{print
>>$1}'`&0x00000001)); do wait; done
>
> I'd rather fix the kernel code. The set_L2CR function in the kernel is
> supposed to already handle all that work of waiting for the cache,
> invalidating, etc...

I fully agree. Just didn't have the time to do so.... there were always
more important bugs to chase ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
