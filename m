Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B21ECB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 09:06:50 +1100 (EST)
Received: by dady9 with SMTP id y9so3254409dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 14:06:48 -0800 (PST)
Date: Fri, 24 Feb 2012 14:06:23 -0800
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Timur Tabi <b04825@freescale.com>
Subject: Re: warnings from drivers/tty/ehv_bytechan.c
Message-ID: <20120224220623.GA29400@kroah.com>
References: <20120220072352.4c8131bbcea69afc007a4297@canb.auug.org.au>
 <4F424985.2020706@freescale.com> <20120224215008.GB25330@kroah.com>
 <4F48086C.5010407@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F48086C.5010407@freescale.com>
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

On Fri, Feb 24, 2012 at 04:00:12PM -0600, Timur Tabi wrote:
> gregkh@linuxfoundation.org wrote:
> > Sure, something like that is fine, but if the code really can't be a
> > module, why not just fix the Kconfig file to enforce this properly
> > instead?
> 
> That's the simplest approach, for use.  The TTY portion of the driver can
> be used as a module.  Is there any real value in loading a TTY driver as a
> module?

Depends on the hardware it supports :)

> In this case, the console support for byte channels would not be
> available.

Then it doesn't make sense, right?

thanks,

greg k-h
