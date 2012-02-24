Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe005.messaging.microsoft.com
 [216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 46B9EB6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 09:00:31 +1100 (EST)
Message-ID: <4F48086C.5010407@freescale.com>
Date: Fri, 24 Feb 2012 16:00:12 -0600
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: warnings from drivers/tty/ehv_bytechan.c
References: <20120220072352.4c8131bbcea69afc007a4297@canb.auug.org.au>
 <4F424985.2020706@freescale.com> <20120224215008.GB25330@kroah.com>
In-Reply-To: <20120224215008.GB25330@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gregkh@linuxfoundation.org wrote:
> Sure, something like that is fine, but if the code really can't be a
> module, why not just fix the Kconfig file to enforce this properly
> instead?

That's the simplest approach, for use.  The TTY portion of the driver can
be used as a module.  Is there any real value in loading a TTY driver as a
module?  In this case, the console support for byte channels would not be
available.

-- 
Timur Tabi
Linux kernel developer at Freescale
