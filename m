Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D3222C015B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 11:35:42 +1100 (EST)
Date: Tue, 2 Apr 2013 19:34:54 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <1363949917.8238.25.camel@jlt4.sipsolutions.net>
 <1363990490.24790.12@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259ED9C2E@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259ED9C2E@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Apr  2 00:28:40 2013)
Message-ID: <1364949294.24520.29@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2013 12:28:40 AM, Wang Dongsheng-B40534 wrote:
> Hi scott & Johannes,
>=20
> Thanks for reviewing.
>=20
> @scott, About this patch, could you please help ack this patch?

Please investigate the issue of whether we are loading kernel module =20
code in this step, and whether cache flushing is needed as a result.

Is there any chance we could even be loading user code here, e.g. if =20
it's mlocked and thus couldn't be swapped out?

-Scott=
