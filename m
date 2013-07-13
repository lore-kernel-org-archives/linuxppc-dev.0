Return-Path: <B40534@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 452D42C036E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 11:08:29 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v2 1/2] powerpc: add Book E support to 64-bit hibernation
Date: Sat, 13 Jul 2013 01:06:52 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259FC41DC@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1373605088-14537-1-git-send-email-dongsheng.wang@freescale.com>
 (from	dongsheng.wang@freescale.com on Thu Jul 11 23:58:08
 2013),<1373665795.8183.289@snotra>
In-Reply-To: <1373665795.8183.289@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0A=
> From: Wood Scott-B07421=0A=
> Sent: Saturday, July 13, 2013 5:49=0A=
> To: Wang Dongsheng-B40534=0A=
> Cc: benh@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Wang Dongshe=
ng-B40534=0A=
> Subject: Re: [PATCH v2 1/2] powerpc: add Book E support to 64-bit hiberna=
tion=0A=
>=0A=
> On 07/11/2013 11:58:08 PM, Dongsheng Wang wrote:=0A=
>> +     /* Invalidate all tlbs */=0A=
>> +     bl      _tlbil_all=0A=
>=0A=
> Again, this will break on non-booke.=0A=
>=0A=
> -Scott=0A=
=0A=
Thanks.=
