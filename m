Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 718B9DE3ED
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 01:43:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PPC to PowerPC Migration
Date: Wed, 11 Jun 2008 08:45:20 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE109603568@tranzeo-mail2.12stewart.tranzeo.com>
In-Reply-To: <f608b67d0806110833h3675232pbaee901ea2664568@mail.gmail.com>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com><161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net><f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com><484FDB3D.4040101@freescale.com>
	<f608b67d0806110833h3675232pbaee901ea2664568@mail.gmail.com>
From: "Darcy Watkins" <DWatkins@tranzeo.com>
To: "vb" <vb@vsbe.com>,
	"Jon Loeliger" <jdl@freescale.com>
Cc: Mike Timmons <mike_timmons@trimble.com>,
	Andy Schmidt <andrewgschmidt@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

And ... for mini PCI, you only have two entries per IDSEL instead of the
usual four.

Regards,

Darcy


--snip!--

my favorite was interrupt-map in PCI section:  A typical value would
look like this:

                interrupt-map =3D <

                        /* IDSEL 0x10 */
                        08000 0 0 1 &mpic 0 1
                        08000 0 0 2 &mpic 1 1
                        08000 0 0 3 &mpic 2 1
                        08000 0 0 4 &mpic 3 1


                        [ repeated per IDSEL ]

               >

I don't see 'interrupt-map' mentioned anywhere in the ./Documentation
tree - it took me a while to find out what these numbers actually
meant.

cheers,
Vadim

--snip!--
