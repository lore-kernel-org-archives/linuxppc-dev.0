Message-Id: <3.0.6.32.19990514115828.008a1330@sins.uia.ac.be>
Date: Fri, 14 May 1999 11:58:28 +0200
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
From: David De Ridder <david.de.ridder@bitsmart.com>
Subject: Re: MVME2431: how to use vme?
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37385A58.BE9B4396@fi.infn.it>
References: <Pine.SO4.4.05.9905111658130.18026-200000@hsins.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 18:27 11-5-99 +0200, Simone Piccardi wrote:

>This time at least I can give to you an answer: looking carefully in the
>Gabriel directory I found that vmetest.c is a new file, and I discover
>also that the patches were newer than the ones I used )this was the
>reason of the compilation failing). I downloaded them, recompiled
>everything, and I could also compile testvme.c.

 So, the _ATTR is in Gabriel's latest patches ?
 For which kernel version are these patches ?

>I find also a new file universe.tex in /usr/src/linux/drivers/vme/ with
>some more info (I'm reading it carefully in this moment).

 That's nice.

>In any case I used your program and by simply changing the "window" with
>"attr" (both in VME_window than in VME_GET_WINDOW and VME_SET_WINDOW) I
>could compile it on the new patches and run it without error.

 Hahahaha. *I* could not compile testvme.c because it had ATTR instead
 of WINDOW, and now *you* have the opposite problem (because *I*
 changed it).

>The problem is in the next step, when I try to write in the remapped
>region I get a bus error (probably is right, because I don't know what
>that region is), but at least when I try to read I have the dataway
>display showing me activities on the bus, and this is enogh for the
>moment!

 We're testing it on an ADC board (it measures charges, converts them
 and writes them into a register ; we read these registers). It seems
 that Gabriel's driver is working fine. Of course, we're not messing
 with interrupts and DMA...yet.

>Now the problem is to understand how to map a board that has a fixed
>address set by jumpers in this way, and I'm still very confused by all
>these VME_AM... constants.
>I'm sending the "improved" version of your program in attachement, the
>only things that it does is to read (showing bus activity) and get a bus
>error when it try to write.

 Thanks. Good luck,



+-----------------------------------------------------------------+
  David 'Septimus' De Ridder       <david.de.ridder@bitsmart.com> 

"The result of two million mad monkeys bashing randomly on
 their keyboards is known today as the Internet."
 - someone

+-----------------------------------------------------------------+
  


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
