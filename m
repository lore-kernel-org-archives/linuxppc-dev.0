Message-Id: <199905060132.SAA26948@soda.CSUA.Berkeley.EDU>
To: Brad Boyer <flar@cegt201.bradley.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB under LinuxPPC 
In-Reply-To: Your message of "Wed, 05 May 1999 16:08:34 CDT."
             <199905052108.QAA24980@cegt201.bradley.edu>
Date: Wed, 05 May 1999 18:32:09 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> This isn't exactly related to what you were asking, but I also have a
> 7600 with a dual processor board, and I have never been able to get an
> SMP kernel to work.  It always dies after it initializes the video.
> So I was wondering, do you use the internal video, or a PCI card?  If
> this is really the problem I'm having, it shouldn't be too hard to
> fix.  If you are using the internal video, could I possibly get a copy
> of the kernel you are using?  Thanks.
 
Hi,

I'm using internal video on the 7600. I never had a problem with the
video but I have had other problems.

In order to get my SMP card (nPower 400) to work under MacOS I had had
to swap out the ROM simm (not sure what its real name is, but its
extra large sized simm) that was in my 7600 with one from an 8500.

A side effect of this is that I can only use boot-x with the "no video
driver" option unchecked for booting into linux. This is not really a
problem for me, since I never boot MacOS on my 7600.

As for SMP kernels, I have only been able to get 2.2.0pre6 with the
file vmscan.c backward patched to 2.2.0pre4 to boot into SMP mode
correctly. The 2.2.1 to 2.2.4 kernels don't boot at all in SMP mode,
they crash in kswapd.  I haven't tried 2.2.5 yet, but from the traffic
on this list I will probably hold off for a little while.

I will put a gzip'ed kernel image on my web page later today and send
you the URL. 

 ----ranga <ranga@soda.berkeley.edu>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
