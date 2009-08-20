Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F2D4AB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 03:44:55 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id 3B363DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 03:44:54 +1000 (EST)
Received: by ywh1 with SMTP id 1so84931ywh.9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 10:44:52 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090820160356.F1A03340054@mail79-sin.bigfish.com>
References: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
	<20090820160356.F1A03340054@mail79-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 20 Aug 2009 11:44:32 -0600
Message-ID: <fa686aa40908201044y17acb4c1lacf09fafc2647fa4@mail.gmail.com>
Subject: Re: [PATCH] [V3] net: add Xilinx emac lite device driver
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sadanand Mutyala <sadanan@xilinx.com>, netdev@vger.kernel.org,
	John Linn <john.linn@xilinx.com>, linuxppc-dev@ozlabs.org,
	John Linn <linnj@xilinx.com>,
	Michal Simek <michal.simek@petalogix.com>, jgarzik@pobox.com,
	davem@davemloft.net, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 20, 2009 at 10:02 AM, Stephen
Neuendorffer<stephen.neuendorffer@xilinx.com> wrote:
>
> John,
>
> I just got a chance to browse this... =A0Do you want to put in the
> stripped device names?
>
> .compatible =3D "xlnx,xps-ethernetlite-2", etc...

We've covered this territory before.  Compatible values need to be
exact for the IP cores.  No wildcards. No abbreviations or stripping.
Newer cores can claim compatibility with older when appropriate.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
