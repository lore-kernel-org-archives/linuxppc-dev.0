Date: Tue, 29 Aug 2000 20:13:48 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
Message-ID: <20000829201347.A30190@hectic.net>
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39AAF258.B43B901@mvista.com>; from mgreer@mvista.com on Mon, Aug 28, 2000 at 04:14:32PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Mark!

On Mon, Aug 28, 2000 at 04:14:32PM -0700, you wrote the following:

> > I've seen that Hard Hat Linux supports the Sandpoint board with
> > MPC8240 and MPC755. We have a 7400 processor there though. Does anyone
> > have any experience with this configuration? Can Linux run on it?
> >
> > Also, is there anything special I should know about booting Linux from
> > dink32? Here's what I did, and how it failed. I got the latest kernel
> > snapshot from fsmlabs (I tried the same with both the latest 2.2 and
> > 2.3 trees).
>
> If you want to use Hard Hat Linux on the Sandpoint, you need to get it from
> Monta Vista's CDK 1.2.  The LSP (Linux Support Package) you're looking for is
> sp8240 (for Sanpoint 8240--also works with a 755/107 combo).  You can find it
> online at ftp://ftp.mvista.com/pub/CDK/1.2/cd/PowerPC/ppc_82xx/RPMS/

I downloaded the kernel and tried it. It starts booting, but it hangs
right after initializing the the OpenPIC. :-( I'll download the source
code tonight and try to look at it, although I don't have much hopes
-- I've never done kernel hacking at that level. At some point you
gotta learn though.

Is there any book that you recommend to get me started? Any other
docs/tips?

> I haven't tested with a 7400 but it should be fairly close if it doesn't work
> right out of the box.  That is, work without altivec.  I don't know what's
> involved to use the altivec support in Linux.

In most kernels I've seen (fsmlabs', and I think yours too) there was
a CONFIG_ALTIVEC option. What does it do?


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

/real/ kernel hackers
    dd if=/dev/urandom of=/vmlinuz
and influence the Universal Randomosity Field.
	-- Gaal Yahas

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
