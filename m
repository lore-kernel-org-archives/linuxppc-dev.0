Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 887EE2C00A7
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2012 02:08:25 +1100 (EST)
Received: by mail-pa0-f42.google.com with SMTP id fa1so311059pad.15
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2012 07:08:21 -0800 (PST)
Date: Wed, 14 Nov 2012 07:09:01 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] TTY: hvc_console, fix port reference count going to zero
 prematurely
Message-ID: <20121114150901.GA2371@kroah.com>
References: <20121114081547.GA573@bloggs.ozlabs.ibm.com>
 <50A36844.7080207@suse.cz> <1352897279.23412.22.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352897279.23412.22.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Jiri Slaby <jslaby@suse.cz>, anton@samba.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 14, 2012 at 11:47:59PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2012-11-14 at 10:45 +0100, Jiri Slaby wrote:
> 
> > > This fixes it by removing the extra kref_put() and tty_kref_put() calls.
> > 
> > Oh yeah. Thanks.
> > 
> > Acked-by: Jiri Slaby <jslaby@suse.cz>
> 
> So who's merging it ?

Give me a chance to at least wake up please :)

I will.

greg k-h
