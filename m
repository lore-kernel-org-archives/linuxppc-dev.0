Date: Thu, 23 Nov 2000 21:42:58 -0500
From: Josh Huber <huber@debian.org>
To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
Message-ID: <20001123213412.A30917@missioncriticallinux.com>
References: <20001122143042.A28078@worldvisions.ca> <Pine.LNX.4.10.10011230936470.22746-100000@opal.biophys.uni-duesseldorf.de> <20001123020959.A11952@worldvisions.ca> <3A1CF40F.5A509ACB@relog.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
In-Reply-To: <3A1CF40F.5A509ACB@relog.ch>; from daenzer@relog.ch on Thu, Nov 23, 2000 at 11:40:15AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2000 at 11:40:15AM +0100, Michel wrote:
> Avery Pennarun wrote:
>
> > Is this a typo?  Why is status information in /etc?
>
> Because it's from pmud, which can't create /proc entries.

I think his problem was with the fact that it's in /etc, when it
should be in /var.

> > It's always better, IMHO, to keep Linux userspace as similar as possible
> > between different architectures.  If pmud has features that apmd doesn't
> > have, or vice versa, I would rather merge them than keep them separate.  In
> > the process, we might as well work on making the kernel interfaces similar
> > too.  That's the whole _point_ of the kernel.
>
> I agree there.

Yes, I've thought this would be a good idea for a while
now...Definately think it's a good idea. hmm...

--
Josh Huber                                   | huber@debian.org |
                                             | Debian Developer |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature
Content-Disposition: inline


--V0207lvV8h4k8FAm--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
