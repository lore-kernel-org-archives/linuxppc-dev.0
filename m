Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 07FE3DE06D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 16:37:52 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2] Parameterize EMAC Multicast Match Handling
Date: Tue, 1 Jul 2008 08:37:45 +0200
References: <C48F0E18.101F1%gerickson@nuovations.com>
	<1214892899.20711.95.camel@pasglop>
In-Reply-To: <1214892899.20711.95.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807010837.45282.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 01 July 2008, Benjamin Herrenschmidt wrote:
> > Stefan and/or Ben:
> >
> > Any thoughts on this?
>
> I was hesitating a bit... do we really need to be -that- flexible ?
>
> That is, either that or use some new compatible entry to detect the new
> reg layout and whack that as a feature bit instead ? The advantage
> of the later is that we have the possibility of doing conditional
> compile for kernels that support only a given processor or set of
> processors (not that we have implemented much of it, but it just
> becomes Kconfig mumbo jumbo and a little bit of defines in the .h
> by turning the feature test into a compile-time 0 or 1.
>
> But this isn't a hot path and not a lot of code so maybe not worth
> bothering... however, it does add 3 properties to the DT and I know
> embedded people (especially Xilinx) are a bit concerned about the size
> of the DT when they try to fit it in block RAM...

Yes, this was my feeling too. Not the size of the dtb but more the increased 
complexity of the EMAC device node. I would prefer Ben's idea with this new 
compatible entry too.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
