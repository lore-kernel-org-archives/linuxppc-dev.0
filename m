Message-Id: <199908310616.IAA00299@piglet.cpu.lu>
Date: Tue, 31 Aug 1999 08:16:35 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card
To: ddkilzer@computer.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v03130301b3f116a864e2@[192.168.1.1]>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  31 Aug, this message from David D. Kilzer echoed through cyberspace:
> Here's what's left of the boot messages on the screen in 2.2.12 from 
> CVS that I compiled on Aug 29, 1999:
> 
[snip]
> Console: switching to colour frame buffer device 104x39
> fb0: control display adapter
> ADB keyboard at 2, handler set to 3
> ADB mouse at 3, handler set to 2
> Serial driver version 4.27 with no serial options enabled
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> Machine check in kernel mode.

This might be a shot in the dark, but I never heard of anyone
successfully compiling in standard serial support on the PowerMacs. I
tried it myself; I would get a panic upon initializing the serial
driver (exactly like above..).

So you might want to disable standard serial suport, and recompile...

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
