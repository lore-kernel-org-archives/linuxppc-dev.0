Message-Id: <199908200558.HAA00345@piglet.cpu.lu>
Date: Fri, 20 Aug 1999 07:58:48 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Various PMac PCI patches
To: ran@krazynet.com
cc: mj@ucw.cz, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990819204726.A82@gondolin.asf>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  19 Aug, this message from Ryan Nielsen echoed through cyberspace:
> Michel Lanners wrote:
>> 2. I've hacked pmac_pcibios_fixup with a few changes:
>> 
>> - It now checks for PCI buses other than the first one, on all bridges.
>> This should help on the 7x00/8x00 machines (bandit and chaos host
>> bridges) as well as on the 9x00 (two bandit bridges; second bus would
>> be invisible up to now). If anyone has a 9x00, can  you test if this
>> works? For me it only detects one of two devices on bus 1....
>  
> It detects two out of two on mi 9600.

Good! I'll give that part of the patch some more polishing (still some
issues with my second bus), and I'll send it out the 'official' way.

> isa_io_base is set to the address of bus 0 !
> so inl() and friends use wrong address for cards on bus 1.

That's expected (and broken) behaviour right now; I know how to correct
the problem, but I need to do some hacking to get it coded right.

Thanks

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
