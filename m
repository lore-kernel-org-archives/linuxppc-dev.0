From: Daniel Wu <Daniel.Wu@alcatel.com.au>
Subject: Re: Using zImage.initrd
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-Id: <00Jun13.090942est.115229@border.alcanet.com.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <00Jun9.083821est.115346@border.alcanet.com.au>
 <3940614D.5BB18EF9@embeddededge.com>
 <00Jun9.185145est.115383@border.alcanet.com.au>
 <394110AB.1B25BBF4@embeddededge.com>
Date: Tue, 13 Jun 2000 09:09:40 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> > > What is the rest of this backtrace?
> > >
> >
> > C00FF71B buf
> > C00B8474 extract_entropy
> > C00B8648 get random_bytes
> > C00FA2B4 init_elf_binfmt
> > C00F7774 start_kernel
> > C000221C start_here
>
> Oh wow.....If this is really where the code is running, something
> very fundamental is broken in the hardware because there should have
> been lots more printed out on the console.  You are still running in
> very generic kernel functions that work on all architectures.
>

But this is only a problem if I do "make zImage.initrd" and not "make zImage". The
latter actually passes this point without error, it fails when it can't get the root
image from the network, when is expected since I am not planning to boot using that
method.

Anyway, I will give your suggestions a try, but my feeling is that they won't make
much difference. BTW, the hardware is not "new" and it works fine with another OS and
applications. I ported the UPM setup from the existing code so I'm pretty sure they
are ok.

Daniel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
