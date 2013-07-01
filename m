Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E41862C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 08:36:51 +1000 (EST)
Date: Mon, 1 Jul 2013 17:36:40 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1372717011.18612.160.camel@pasglop> (from
 benh@kernel.crashing.org on Mon Jul  1 17:16:51 2013)
Message-ID: <1372718200.8183.96@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/2013 05:16:51 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-07-01 at 11:55 -0500, Scott Wood wrote:
> > I've been picking patches and hope to send a pull request soon.  I
> > already have these patches queued up as part of it.
>=20
> Hurry !
>=20
> Next time, I'd like the bulk of your stuff around -rc2 or 3 if =20
> possible,
> ie, keep feeding me rather than one big pull in the merge window.
>=20
> Thanks !

I'll send it tonight after I verify no obvious breakage.

I realize it's late, but I wasn't involved until a few weeks ago, and =20
there was a large backlog (of which I've only been able to get through =20
a portion so far).  Most of what I have gone through was done in the =20
past week -- I wasn't just holding on to it.

-Scott=
