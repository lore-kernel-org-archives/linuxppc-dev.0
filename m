Return-Path: <B43644@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AC902C00AF
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Aug 2013 12:33:05 +1000 (EST)
From: Liu Po-B43644 <B43644@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree for C293
Date: Thu, 1 Aug 2013 02:32:58 +0000
Message-ID: <D473A0D087F4EA47A30C37E4637E25E609DB5B7F@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1374806479-812-3-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-1-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-2-git-send-email-Po.Liu@freescale.com>
 <1375208891.30721.74@snotra>
 <D473A0D087F4EA47A30C37E4637E25E609DB5966@039-SN2MPN1-023.039d.mgd.msft.net>
 <1375285614.30721.90@snotra>
In-Reply-To: <1375285614.30721.90@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>  -----Original Message-----
>  From: Wood Scott-B07421
>  Sent: Wednesday, July 31, 2013 11:47 PM
>  To: Liu Po-B43644
>  Cc: Wood Scott-B07421; linuxppc-dev@ozlabs.org; galak@kernel.crashing.or=
g;
>  Fleming Andy-AFLEMING; Hu Mingkai-B21284
>  Subject: Re: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree for
>  C293
> =20
>  On 07/30/2013 09:13:28 PM, Liu Po-B43644 wrote:
>  >
>  > >  -----Original Message-----
>  > >  From: Wood Scott-B07421
>  > >  Sent: Wednesday, July 31, 2013 2:28 AM
>  > >  To: Liu Po-B43644
>  > >  Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Fleming
>  > Andy-
>  > >  AFLEMING; Hu Mingkai-B21284; Liu Po-B43644
>  > >  Subject: Re: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree
>  > for
>  > >  C293
>  > >
>  > >  On 07/30/2013 03:49:22 AM, Po Liu wrote:
>  > >  > +	crypto@80000 {
>  > >  > +/include/ "qoriq-sec6.0-0.dtsi"
>  > >  > +	};
>  > >  > +
>  > >  > +	crypto@80000 {
>  > >  > +		reg =3D <0x80000 0x20000>;
>  > >  > +		ranges =3D <0x0 0x80000 0x20000>;
>  > >  > +
>  > >  > +		jr@1000{
>  > >  > +			interrupts =3D <45 2 0 0>;
>  > >  > +		};
>  > >  > +		jr@2000{
>  > >  > +			interrupts =3D <57 2 0 0>;
>  > >  > +		};
>  > >  > +	};
>  > >
>  > >  Do these inline the way the example shows.
>  > Sorry, Scott, I just remember in this way, the node can't be
>  > recognized by system when run Uboot. The include can't be in the
>  > crypto@80000. See the discussion in
>  > http://git.am.freescale.net:8181/#/c/736/  .
>  > Maybe I should re-modify the example file.
> =20
>  git.am.freescale.net is not accessible outside of Freescale; don't
>  reference it on external lists.  In any case, I don't know what
>  specifically you want me to look at there.  Just put the explanation her=
e.
Sorry, I've realize that.
The fact is that: when put the include into the crypto@xxxx, it can't compi=
le success(make c293pcie.dtb as example). Error will show as:

ERROR (duplicate_node_names): Duplicate node name /soc@fffe00000/crypto@800=
00/jr@1000
 =20
>  I do not expect the dtc output to be any different between the two
>  methods.  Could you check this (by using dtc to decompile the dtb
>  afterward) and point out exactly how the output differs between the two
>  approaches?
Since it will compile error in this way, so will not output .dtb file
> =20
>  -Scott
