Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B6301007D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 16:01:28 +1100 (EST)
Date: Thu, 27 Oct 2011 06:51:03 +0200
From: Greg KH <greg@kroah.com>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH v15 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
Message-ID: <20111027045103.GA609@kroah.com>
References: <1318630114-14064-1-git-send-email-tmarri@apm.com>
 <20111021173302.GB27652@quad.lixom.net>
 <c898f5030d342baa4df570317536bcf2@mail.gmail.com>
 <CAOesGMhVuxbqq7cmm2XVUof9vEifAL=GpPirYb8148a24upJCw@mail.gmail.com>
 <0a2f495d6415e9cad48ae2c75c582e0d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0a2f495d6415e9cad48ae2c75c582e0d@mail.gmail.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 26, 2011 at 10:17:19AM -0700, Tirumala Marri wrote:
> Greg,
> 
> <
> <No, just start over from scratch. Just leave the crap driver behind,
> <use it for reference but write the new one.

What email client are you using, I have never seen this type of
formatting, and it makes it impossible to read your replies.  Please
resolve this.

> <It's obvious given that you are already at iteration v15 and it's
> <still looking this bad that this is not realistic to get reviewed and
> <accepted as-is. I don't think staging is a good target either -- what
> <the driver really needs is _functional_ cut-down to only cover the use
> <cases that your product uses, and staging cleanups are mostly around
> <style and refactoring, not changing, fixing or removing functionality.
> <
> <> <Compare this to the dwc3 driver, which is much much cleaner.
> <> <
> Could you please comment on this. This has been reviewed so many times
> And we did the major changes. I think it is un-acceptable to say to
> re-write
> The driver now after 15 reviews? This should have happened in first 5
> reviews.

Sometimes people miss things on previous reviews, this is not a perfict
system, only the best that we currently know how to do, don't you agree?

If this driver contains lots of things that are not necessary for it to
work at this point in time, why wouldn't that be removed now?

Anyway, I think it would probably be best to get this into staging for
now, which will help you get a way to clean it up in an easier manner,
and still have users have access to it.  Is that acceptable?

thanks,

greg k-h
