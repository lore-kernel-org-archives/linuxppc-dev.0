Message-ID: <389537D2.D4642F0A@wanadoo.fr>
Date: Mon, 31 Jan 2000 08:20:50 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: ramp@oddjob.uchicago.edu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: devel kernels 2.3.41
References: <Pine.LNX.4.10.10001302151040.3009-100000@xpol.uchicago.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The 2.3.41 final kernel is broken on most non-intel architectures (dma
code changed completely). I would think (and hope) the PPC kernel
developers are too busy fixing this right now to answer your question.

And many people, even on intel hardware, are seeing file system
corruption with 2.3.x kernels. Plus, the new USB code probably doesn't
work yet.

So for non-kernel-developers this means to be patient for a while.

ramp@oddjob.uchicago.edu wrote:
>
> Hi everyone,
>
> I hope I'm not the only one having problems getting a working
> 2.3.41 kernel. I downloaded the stock 2.3.41 from kernel.org.
> This one didn't even compile. There were some problems with
> pci.h. I then decided to go back to 2.3.40 and apply the
> pre-patches [1..4] where 4 is the final 2.3.41. I was able
> to successfully compile a 2.3.41pre3. However on boot I was
> unable to use my keyboard/mouse. The boot messages seemed to
> indicate that the keyboard and mouse were recognized. Any ideas
> and fixes? 2.3.41pre2 also compiled successfully. On boot this
> led to disk errors and I was asked to fsck. This was a total loss
> since I could not type anything with the keyboard and mouse not
> even recognized. I'm now back to my 2.2.14 and things seem OK.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
