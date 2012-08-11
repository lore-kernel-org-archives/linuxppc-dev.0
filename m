Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 937E42C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 23:10:19 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
Date: Sat, 11 Aug 2012 13:10:09 +0000
Message-ID: <CAOZdJXWmLgRM9t6Cus=5kfOwjmAFSg+hjNXyd1cR7GtJ8k0Qew@mail.gmail.com>
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
In-Reply-To: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
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

On Fri, Aug 10, 2012 at 12:54 AM,  <Dongsheng.wang@freescale.com> wrote:
> From: Wang Dongsheng <Dongsheng.Wang@freescale.com>

> +EXPORT_SYMBOL_GPL(mpic_request_timer);

Make these EXPORT_SYMBOL.  No need for a GPL restriction.

--=20
Timur Tabi
Linux kernel developer at Freescale=
