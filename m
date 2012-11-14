Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DC042C00AC
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2012 07:54:12 +1100 (EST)
Received: by mail-pb0-f42.google.com with SMTP id rp2so571887pbb.15
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2012 12:54:10 -0800 (PST)
Date: Wed, 14 Nov 2012 12:54:07 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] TTY: hvc_console, fix port reference count going to zero
 prematurely
Message-ID: <20121114205407.GA7937@kroah.com>
References: <20121114081547.GA573@bloggs.ozlabs.ibm.com>
 <50A36844.7080207@suse.cz> <1352897279.23412.22.camel@pasglop>
 <20121114150901.GA2371@kroah.com>
 <1352926097.23412.24.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352926097.23412.24.camel@pasglop>
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

On Thu, Nov 15, 2012 at 07:48:17AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2012-11-14 at 07:09 -0800, Greg KH wrote:
> > > So who's merging it ?
> > 
> > Give me a chance to at least wake up please :)
> 
> Sure ;-) Just asking since I'm about to cook up a powerpc batch :-)

It's now in my tree, and will get to Linus in time for 3.7.

> > I will.
> 
> Thanks ! It should go into stable 3.6 as well.

Why?  The offending patch didn't show up until 3.7-rc1.

thanks,

greg k-h
