Message-Id: <199908310407.VAA28309@soda.CSUA.Berkeley.EDU>
To: "David D. Kilzer" <ddkilzer@computer.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card 
In-Reply-To: Your message of "Mon, 30 Aug 1999 00:54:50 CDT."
             <v0313030fb3efcb9a9d0f@[192.168.1.1]>
Date: Mon, 30 Aug 1999 21:07:35 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

I think that I have the same card, the nPower 400 (2 604e 200's).

So far I have only been able to boot two SMP kernels on it in R4, my
own 2.2.0pre6 kernel and Charles L.'s (from borg.mit.edu) 2.2.7
kernel.

When I build another kernel, either from pmac repository or from
kernel.org, I get a crash in kswapd during boot. I'm not sure by I am
beginning to suspect it has something to do with the amount of swap I
have configured. I had lots of problems when I was using the old rule
of thumb 2 x Main Mem + 1 MB, which was about 257 MB for me.  I have
reduced it to 122876 kB and this seems to work better.

I have never been able to boot a SMP kernel using R5.

----ranga <ranga@soda.berkeley.edu>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
