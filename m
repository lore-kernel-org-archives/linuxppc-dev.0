Date: Sun, 24 Mar 02 20:19:58 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203250419.AA26599@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nye Liu <nyet@zumanetworks.com> wrote:

> Mike S: I would also be VERY interested in any work you may have already
> done in the mpsc or eth drivers; especially with regards to SMP and
> cache coherency.

I already wrote about this in my long posting.

> i would
> still like other GT EVB users lurking here to stress test the _galileo
> tree as best they can, since right now, I seem to be the only active
> developer with an EVB contributing to _gal.

Well, EV-64260 is completely broken in the 2_4_galileo tree, and has been so
from the moment I first looked at it through now inclusive. Since 2_4_devel
works so much better for me and is closer to my goal of stable support in 2.4
release tarballs on kernel.org, I really have no incentive to mess with the
2_4_galileo crap.

Just to tell everyone honestly how I really feel, IMHO 2_4_galileo is Nye's
play tree and I strongly recommend against anyone other than Nye using it.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
