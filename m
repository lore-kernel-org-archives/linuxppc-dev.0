Return-Path: <vbendeb@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 87FF1DE2F8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 02:03:43 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1894255ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 09:03:32 -0700 (PDT)
Message-ID: <f608b67d0806110903ta0054eke85eb33d411b638f@mail.gmail.com>
Date: Wed, 11 Jun 2008 09:03:31 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: "Darcy Watkins" <DWatkins@tranzeo.com>
Subject: Re: PPC to PowerPC Migration
In-Reply-To: <D61182AC8012EA4EBC531B3AF23BE109603568@tranzeo-mail2.12stewart.tranzeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
	<484FDB3D.4040101@freescale.com>
	<f608b67d0806110833h3675232pbaee901ea2664568@mail.gmail.com>
	<D61182AC8012EA4EBC531B3AF23BE109603568@tranzeo-mail2.12stewart.tranzeo.com>
Cc: linuxppc-embedded@ozlabs.org, Mike Timmons <mike_timmons@trimble.com>,
	Andy Schmidt <andrewgschmidt@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2008 at 8:45 AM, Darcy Watkins <DWatkins@tranzeo.com> wrote:
> Hello,
>
> And ... for mini PCI, you only have two entries per IDSEL instead of the
> usual four.
>
And of course in reality you need just one! :-)
/vb

> Regards,
>
> Darcy
>
>
> --snip!--
>
> my favorite was interrupt-map in PCI section:  A typical value would
> look like this:
>
>                interrupt-map = <
>
>                        /* IDSEL 0x10 */
>                        08000 0 0 1 &mpic 0 1
>                        08000 0 0 2 &mpic 1 1
>                        08000 0 0 3 &mpic 2 1
>                        08000 0 0 4 &mpic 3 1
>
>
>                        [ repeated per IDSEL ]
>
>               >
>
> I don't see 'interrupt-map' mentioned anywhere in the ./Documentation
> tree - it took me a while to find out what these numbers actually
> meant.
>
> cheers,
> Vadim
>
> --snip!--
>
