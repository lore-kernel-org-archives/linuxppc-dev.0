Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06F81B71A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 14:29:21 +1000 (EST)
Subject: Re: [PATCH 2/2][v3] rapidio,
	powerpc/85xx: Error interrupt handler for sRIO.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=windows-1252
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E5520162CA22@CORPEXCH1.na.ads.idt.com>
Date: Thu, 19 May 2011 23:28:55 -0500
Message-Id: <6CBDFAB4-F884-4B33-8A77-0AE2CF2D2ED4@kernel.crashing.org>
References: <1290063473-20950-1-git-send-email-b21989@freescale.com><0CE8B6BE3C4AD74AB97D9D29BD24E552015F5E40@CORPEXCH1.na.ads.idt.com>
	<267A3B246C22C34A8E574051858E077002E834@039-SN1MPN1-003.039d.mgd.msft.net>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520162CA22@CORPEXCH1.na.ads.idt.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Cc: Li Yang-R58472 <r58472@freescale.com>,
	Xie Shaohui-B21989 <B21989@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alex,

What are we doing with this patch?

- k

On Dec 3, 2010, at 12:04 PM, Bounine, Alexandre wrote:

> I think they should follow the previous two that are in Kumar=92s =
tree.
> Probably Kumar may give you a better timeline estimate for this.  =20
>=20
> Alex.
>=20
> From: linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org =
[mailto:linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org]=
 On Behalf Of Xie Shaohui-B21989
> Sent: Thursday, December 02, 2010 10:29 PM
> To: Bounine, Alexandre; linuxppc-dev@lists.ozlabs.org
> Cc: akpm@linux-foundation.org; Gala Kumar-B11780; Li Yang-R58472; Zang =
Roy-R61911
> Subject: RE: [PATCH 2/2][v3] rapidio,powerpc/85xx: Error interrupt =
handler for sRIO.
>=20
> Hi Alex,
>=20
> May I ask when would these patches be applied to mainline?
>=20
>=20
> Best Regards,=20
> Shaohui Xie
>=20
> From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]=20
> Sent: Wednesday, December 01, 2010 4:49 AM
> To: Xie Shaohui-B21989; linuxppc-dev@lists.ozlabs.org
> Cc: akpm@linux-foundation.org; Li Yang-R58472; Gala Kumar-B11780; Zang =
Roy-R61911
> Subject: RE: [PATCH 2/2][v3] rapidio, powerpc/85xx: Error interrupt =
handler for sRIO.
>=20
> Applies correctly now. Lab tested on 8548/RIO setup.
>=20
> Alex.
>=20
>> -----Original Message-----
>> From: Shaohui Xie [mailto:b21989@freescale.com]
>> Sent: Thursday, November 18, 2010 1:58 AM
>> To: linuxppc-dev@lists.ozlabs.org
>> Cc: akpm@linux-foundation.org; Shaohui Xie; Li Yang; Kumar Gala; Roy
> Zang; Bounine, Alexandre
>> Subject: [PATCH 2/2][v3] rapidio, powerpc/85xx: Error interrupt
> handler for sRIO.
>>=20
>> The sRIO controller reports errors to the core with one signal, it
> uses
>> register EPWISR to provides the core quick access to where the error
> occurred.
>> The EPWISR indicates that there are 4 interrupts sources, port1,
> port2, message
>> unit and port write receive, but the sRIO driver does not support
> port2
>> for now, still the handler takes care of port2.
>> Currently the handler only clear error status without any recovery.
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
