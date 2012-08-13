Return-Path: <B40534@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E7C642C0098
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2012 16:21:04 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [PATCH v2 2/2] powerpc/mpic: add global timer support
Date: Mon, 13 Aug 2012 06:20:56 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259DB14DD@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
 <CAOZdJXWmLgRM9t6Cus=5kfOwjmAFSg+hjNXyd1cR7GtJ8k0Qew@mail.gmail.com>
In-Reply-To: <CAOZdJXWmLgRM9t6Cus=5kfOwjmAFSg+hjNXyd1cR7GtJ8k0Qew@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Saturday, August 11, 2012 9:10 PM
> To: Wang Dongsheng-B40534
> Cc: benh@kernel.crashing.org; paulus@samba.org; Wood Scott-B07421; Gala
> Kumar-B11780; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
>=20
> On Fri, Aug 10, 2012 at 12:54 AM,  <Dongsheng.wang@freescale.com> wrote:
> > From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
>=20
> > +EXPORT_SYMBOL_GPL(mpic_request_timer);
>=20
> Make these EXPORT_SYMBOL.  No need for a GPL restriction.
>=20
[Wang Dongsheng] Why?
> --
> Timur Tabi
> Linux kernel developer at Freescale
