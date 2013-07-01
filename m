Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54ACB2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 02:55:29 +1000 (EST)
Date: Mon, 1 Jul 2013 11:55:16 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259EE77D8@039-SN2MPN1-021.039d.mgd.msft.net>
 <1366155021.23030.24@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259F2581C@039-SN2MPN1-022.039d.mgd.msft.net>
 <1368421223.19924.16.camel@pasglop>
 <ABB05CD9C9F68C46A5CEDC7F15439259F916BF@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259F916BF@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Sun Jun 30 21:38:15 2013)
Message-ID: <1372697716.8183.81@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2013 09:38:15 PM, Wang Dongsheng-B40534 wrote:
> Hi Benjamin & Kumar & scott,
>=20
> I am not sure who can apply these patches...
>=20
> Scott already ACK these patches.
>=20
> A few days ago Scott have a pull request, Scott can accept them? Or ?
>=20
> [v3,1/4] powerpc/mpic: add irq_set_wake support
> http://patchwork.ozlabs.org/patch/234934/
>=20
> [v3,2/4] powerpc/mpic: add global timer support
> http://patchwork.ozlabs.org/patch/234935/
>=20
> [v3,3/4] powerpc/mpic: create mpic subsystem object
> http://patchwork.ozlabs.org/patch/234936
>=20
> [v3,4/4] powerpc/fsl: add MPIC timer wakeup support
> http://patchwork.ozlabs.org/patch/234937/

I've been picking patches and hope to send a pull request soon.  I =20
already have these patches queued up as part of it.

-Scott=
