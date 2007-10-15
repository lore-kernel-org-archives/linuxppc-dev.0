Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 3D499DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:19:48 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3944697pyi
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 12:19:47 -0700 (PDT)
Message-ID: <fa686aa40710151219l1d0da6aduccf29994cb23a365@mail.gmail.com>
Date: Mon, 15 Oct 2007 13:19:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jeff Garzik" <jgarzik@pobox.com>
Subject: Re: [PATCH v3 0/4] FEC - fast ethernet controller for mpc52xx
In-Reply-To: <4713BA1C.2050604@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014075511.GC3000@nd47.coderock.org>
	<4713BA1C.2050604@pobox.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Jeff Garzik <jgarzik@pobox.com> wrote:
> Domen Puncer wrote:
> > Hello!
> >
> > If there are no objections, I would like to get this merged
> > when bestcomm goes in (any time now?).
> >
> > It's split into four parts:
> > 1 - device tree
> > 2 - small bestcomm change
> > 3 - the actual driver
> > 4 - phy part of the driver
>
> patches #3 and #4 need to be combined together.
>
> Are the arch people OK with patches #1 and #2?

Yes, I'll be pushing both to Paulus shortly.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
