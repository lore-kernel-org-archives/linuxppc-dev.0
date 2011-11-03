Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0AF80B6F7D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 01:12:50 +1100 (EST)
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AEA4@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AEA4@saturn3.aculab.com>
MIME-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Message-ID: <48111653-5285-4BF3-B0EA-36EC6A635155@freescale.com>
From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/usb: use unsigned long to type cast an address of
 ioremap
Date: Thu, 3 Nov 2011 09:12:44 -0500
To: David Laight <David.Laight@ACULAB.COM>
Cc: "<linux-usb@vger.kernel.org>" <linux-usb@vger.kernel.org>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Nov 3, 2011, at 7:16 AM, David Laight <David.Laight@ACULAB.COM> wrote:

> Arithmetic on 'void *' should not be done. I know some versions of
> gcc allow it (provided some warning level/option is enabled) but
> that doesn't mean it is valid.
> My suspicions are that is was allowed due to the way 'void *'
> was originally bodged into gcc.

Well, I don't know what else to say.  Arithmetic on void* is done all over t=
he kernel.  You're a little late to the party if you're going to advocate it=
s avoidance. =20
