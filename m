From: Brad Boyer <flar@cegt201.bradley.edu>
Message-Id: <199905060329.WAA28970@cegt201.bradley.edu>
Subject: Re: USB under LinuxPPC
To: ranga@CSUA.Berkeley.EDU (Sriranga Veeraraghavan)
Date: Wed, 5 May 1999 22:29:23 -0500 (CDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199905060132.SAA26948@soda.CSUA.Berkeley.EDU> from "Sriranga Veeraraghavan" at May 5, 99 06:32:09 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> In order to get my SMP card (nPower 400) to work under MacOS I had had
> to swap out the ROM simm (not sure what its real name is, but its
> extra large sized simm) that was in my 7600 with one from an 8500.

If it was the one in the middle of the RAM slots, that's the L2 cache,
and I assume it is, since the one in my 7600 didn't cooperate with the
my nPower400 card either.  I didn't have anything to replace it with,
so I just took it out.  I really should get a better one for
performance reasons, but I just haven't done it yet.

> A side effect of this is that I can only use boot-x with the "no video
> driver" option unchecked for booting into linux. This is not really a
> problem for me, since I never boot MacOS on my 7600.

Do you always use BootX?  I've never even tried it...

> As for SMP kernels, I have only been able to get 2.2.0pre6 with the
> file vmscan.c backward patched to 2.2.0pre4 to boot into SMP mode
> correctly. The 2.2.1 to 2.2.4 kernels don't boot at all in SMP mode,
> they crash in kswapd.  I haven't tried 2.2.5 yet, but from the traffic
> on this list I will probably hold off for a little while.

Well, that's definitely a different place than it crashed for me in
2.2.2 and 2.2.5, and I never tried more than a little at any of the
2.2.0pre kernels.  Maybe I'll take a look and see what changed...

> I will put a gzip'ed kernel image on my web page later today and send
> you the URL. 

Thanks.  If you have any modules, could you include them too?  I'd
appreciate it.

		Brad Boyer
		flar@cegt201.bradley.edu

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
