Return-Path: <hadess@hadess.net>
Received: from slow1-d.mail.gandi.net (slow1-d.mail.gandi.net [217.70.178.86])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wbLkl3RqTzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 May 2017 23:46:39 +1000 (AEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by slow1-d.mail.gandi.net (Postfix) with ESMTP id C6FA847A486
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 May 2017 15:26:37 +0200 (CEST)
Message-ID: <1495977983.2423.18.camel@hadess.net>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
From: Bastien Nocera <hadess@hadess.net>
To: Michal Suchanek <msuchanek@suse.de>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Date: Sun, 28 May 2017 15:26:23 +0200
In-Reply-To: <20170528114758.52b619f2@neko>
References: <20170509191418.10144-1-msuchanek@suse.de>
 <20170510004327.GA32584@dtor-ws> <20170528114758.52b619f2@neko>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-05-28 at 11:47 +0200, Michal Suchanek wrote:
> On Tue, 9 May 2017 17:43:27 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Michal,
> > 
> > On Tue, May 09, 2017 at 09:14:18PM +0200, Michal Suchanek wrote:
> > > There is nothing mac-specific about this driver. Non-mac hardware
> > > with suboptimal built-in pointer devices exists.
> > > 
> > > This makes it possible to use this emulation not only on x86 and
> > > ppc
> > > notebooks but also on arm and mips.  
> > 
> > I'd rather we did not promote from drivers/macintosh to other
> > platforms, but rather removed it. The same functionality can be
> > done
> > from userspace.
> 
> What is the status of this?
> 
> Do you reply to every patch to drivers/input that is not the the core
> infrastructure that you would rather drop the driver because it can
> be
> done is in userspace?
> 
> It sure can be done. Remove everything but the bus drivers and uinput
> from drivers/input and the rest can be done in userspace.
> 
> The question is who does it?
> 
> Are you saying that you will implement the userspace equivalent?
> 
> If not then please do your job as maintainer and accept trivial
> patches
> for perfectly working drivers we have now.
> 
> If you want to move drivers/input into userspace I am not against it
> but I am not willing to do that for you either.

I'd advise you to take it down a notch. We don't go yelling at each
other on this mailing-list.
