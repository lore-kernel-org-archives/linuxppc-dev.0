Message-ID: <37E72316.B63EBD9E@wanadoo.fr>
Date: Tue, 21 Sep 1999 08:17:58 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.whatever and hfs
References: <v03130302b40ca89cb4be@[192.168.1.1]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David D. Kilzer" wrote:
> 
> David Riley <happyoscar42@usa.net> wrote:
> >The current vger 2.3 kernel (whatever it is, maybe 2.3.18) compiles
> >without a hitch, except at the end when it's linking it all up and it
> >dies with an unresolved symbol "update_vm_chache" in hfs.o.  I'd like to
> >be able to use hfs with my 2.3 kernel; is there a fix for this?
> 
> Yes.  Someone must rewrite the HFS code to use the new unified buffer code.
> I think both minixfs and ext2fs have been rewritten, but HFS and other
> 'foreign' file systems have not been rewritten.
> 
> The short-term solution is not to include support for HFS in your kernel.
> 
> The long-term solution is to fix HFS to work with the new unified buffer
> code.  Unfortunately, the HFS maintainer is busy and may not be able to fix
> this until well into 2.4.

So in the next stable kernel version, we will not have HFS support and,
of course, even less HFS+ support! Is there really nobody in the
linuxppc developers community who can do this? The current maintainer
has been inactive since 7 months (see the archives from February), so he
could not really object if someone else took over.

> Personally, I think that, "if you break it, you fix it," but apparently
> this doesn't always apply to kernel internals.

And never has applied to the PPC port, unfortunately.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
