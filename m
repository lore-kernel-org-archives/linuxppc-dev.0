Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B656C2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2012 04:57:54 +1100 (EST)
Received: by mail-pa0-f51.google.com with SMTP id fb11so4270103pad.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2012 09:57:51 -0800 (PST)
Date: Sat, 24 Nov 2012 09:59:10 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 056/493] edac: remove use of __devexit_p
Message-ID: <20121124175910.GA2223@kroah.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-56-git-send-email-wfp5p@virginia.edu>
 <20121122134451.GG17147@x1.alien8.de>
 <20121122182222.GB25392@kroah.com>
 <20121123100635.GC18765@x1.alien8.de>
 <20121123164024.GB5471@kroah.com>
 <20121124091453.GC25143@x1.alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121124091453.GC25143@x1.alien8.de>
Cc: "Arvind R." <arvino55@gmail.com>, Mark Gross <mark.gross@intel.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>,
 Jason Uhlenkott <juhlenko@akamai.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Bill Pemberton <wfp5p@virginia.edu>, Egor Martovetsky <egor@pasemi.com>,
 Doug Thompson <dougthompson@xmission.com>, Olof Johansson <olof@lixom.net>,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Tim Small <tim@buttersideup.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 24, 2012 at 10:14:53AM +0100, Borislav Petkov wrote:
> On Fri, Nov 23, 2012 at 08:40:24AM -0800, Greg KH wrote:
> > No, as there will not be any discarded sections anymore because
> > CONFIG_HOTPLUG is always enabled. We will just delete this whole
> > #if/#endif section once all users of __devexit_p() are gone from the
> > tree.
> >
> > Does that help out?
> 
> Yes, I missed the fact that there won't be any discarded sections
> anymore. Btw, in that case, you'd probably need to remove all those
> 
> #ifdef CONFIG_HOTPLUG
> 
> ...
> 
> #endif
> 
> stanzas surrounding different places in the kernel (I see 40ish
> currenty) now that HOTPLUG is def_bool y and if you haven't done so yet.

That removal was done as part of this 493 patches long patchset :)

> Thanks for explaining.
> 
> Btw, you can have my
> 
> Acked-by: Borislav Petkov <bp@alien8.de>
> 
> for the amd64_edac pieces.

Thanks, I will add it there,

greg k-h
