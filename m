Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id B5C2ADDE2C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 14:22:51 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so801524anc
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Dec 2007 19:22:50 -0800 (PST)
Message-ID: <fa686aa40712031922j3ae16c8eo203a6b0b7c28523f@mail.gmail.com>
Date: Mon, 3 Dec 2007 20:22:50 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] [v2] Improved documentation of device tree
	'ranges'.
In-Reply-To: <20071204024025.GG32577@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071204010818.AD4231798062@mail212-sin.bigfish.com>
	<20071204024025.GG32577@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/3/07, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Mon, Dec 03, 2007 at 05:08:57PM -0800, Stephen Neuendorffer wrote:
> > I was misled by the prior language.  I've attempted to clarify how
> > 'ranges' are used, in particular, how to get an identity mapping.
> >
> > Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>
> Thanks for the update.  I particularly dislike the "1:1" terminology,
> because in maths-speak *any* ranges translation is 1:1, unless it
> includes overlapping ranges.
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
