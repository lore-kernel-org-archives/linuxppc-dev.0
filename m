From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: R Shapiro <reshapiro@mediaone.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: new aic7xxx driver DOES NOT WORK with cdrecord
Date: Sat, 31 Mar 2001 19:14:14 +0200
Message-Id: <20010331171414.19066@smtp.wanadoo.fr>
In-Reply-To: <15045.61890.58237.453470@ipa.ne.mediaone.net>
References: <15045.61890.58237.453470@ipa.ne.mediaone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>A little while ago I reported a puzzling change to scsi behavior in
>the 2.4.3 kernels.  I didn't get any explanation of what was going on,
>but after burning half a dozen coasters on a scsi CD-R, testing
>various kernel configs, I think I finally understand what's happening.
>A completely new driver for aic7xxx was introduced in 2.4.3, or
>thereabouts, and it just doesn't work for CD-Rs.  For now it's still
>possible to load the old driver (CONFIG_SCSI_AIC7XXX_OLD), which I
>only just discovered, and this driver works fine.  But according to
>the documentation, support for this will supposedly be removed soon.
>
>Who should I report this problem to? Does Adaptec write these linux
>drivers or is it done by a volunteer working on his/her own?  Ideally
>I'd like to use the newer driver, if it can be made to work properly.
>At the very least I'd like to ensure that the old driver isn't removed
>before the new one works.

The new driver is written & maintained by Justin T. Gibbs
<gibbs@scsiguy.com>, who is, I think, supported (or working for)
Adaptec. It's supposed to be _much_ better than the old one (and
actually gives better throughput on the 29160N in my G4).

Justin is pretty responsive to problem reports, I would suggest
you contact him and eventually CC to the linux-kernel mailing
list. I think he does have a PPC to test with.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
