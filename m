Message-Id: <199907010554.HAA00267@piglet.cpu.lu>
Date: Thu, 1 Jul 1999 07:54:51 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Promise Ultra33 in PowerMac?
To: hedrick@Astro.Dyer.Vanderbilt.Edu, fray@kernel.crashing.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96.990310222255.22565A-100000@Astro.Dyer.Vanderbilt.Edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Andre and Mark,

On  10 Mar, this message from Andre M. Hedrick echoed through cyberspace:
>> I'm thinking about adding a Promise Ultra33 UDMA IDE controller to my
>> PowerMac. Those things, and especially the IDE disks, are so damned
>> cheap...
> 
> I have inital patches to allow a PPC with PCI support to use an Ultra33;
> however, the individual that started tests never finished them.

Any news on the subject? I'll probably go shopping next week, so now's
the time to buy one of those boards, if there is a chance we can get
them to work...

How's the status of the Ultra/66 support under Linux? Your patches seem
to include support, but is it usable? I might not be able to get an
Ultra/33 anymore; most shops around here don't have them anymore. Plus,
the Ultra/66 costs exactly the same as the Ultra/33 before; so I might
as well get the best choice right now...

Do you think you have all the necessary code for the setup of the
board in your driver? As the on-board i386 BIOS code will not be
executed, this might be the biggest problem. As a 'dirty' solution, one
might try to use a bare-bones i386 emulator to run the BIOS code. That
has been done before for a VGA board on a PowerPC. If I remember
correctly, that emulator needed only around 100 kB of code... 

Any thoughts about Maxtor drives in general, and the Diamond Max Plus
5120 (91024D4) specifically? That one seems to be fast and quiet...
optimal choice for a desktop box!

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
