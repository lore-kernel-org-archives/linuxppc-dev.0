Date: Tue, 25 Feb 2003 17:44:25 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Oops when inserting PCMCIA flash card (IDE)
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15963.417.778407.277896@argo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E18niBz-0007zZ-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  25 Feb, this message from Paul Mackerras echoed through cyberspace:
> Michel Lanners writes:
>
>> For a number of kernel versions (at least 4 months) I get a kernel oops
>> when inserting a CF card in my TiBook's PCMCIA slot.
> [snip]
>> The NIP in the oops points to ide_mm_inb(); it's trying to read from the
>> IDE ports. However, the port the new IDE interface got assinged seems to
>
> It should of course be using ide_inb().

[snip]

> In the meantime I am using this hack:

[snip]

Thanks Paul, works OK for me on BenH's 2.4.21-pre3.

Hope you get Alan to find a final fix :-)

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
