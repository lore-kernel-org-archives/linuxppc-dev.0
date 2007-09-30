Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 63964DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Oct 2007 00:28:40 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so4488783wag
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Sep 2007 07:28:39 -0700 (PDT)
Message-ID: <9e4733910709300728p1f1a2c87vad38a2b047da54e0@mail.gmail.com>
Date: Sun, 30 Sep 2007 10:28:39 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Sven Luther" <sven@genesi-usa.com>
Subject: Re: Efika, initrd and current kernel
In-Reply-To: <20070930141926.GA1431@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910709292205p7b1cdda9m661b241908fdedab@mail.gmail.com>
	<46FF7A7D.6040300@genesi-usa.com>
	<9e4733910709300709t72078992s1bad7967c565b6e1@mail.gmail.com>
	<20070930141926.GA1431@powerlinux.fr>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/30/07, Sven Luther <sven@genesi-usa.com> wrote:
> On Sun, Sep 30, 2007 at 10:09:47AM -0400, Jon Smirl wrote:
> > On 9/30/07, Matt Sealey <matt@genesi-usa.com> wrote:
> > > How did you build the kernel?
> >
> > I attached the .config
> > Am I supposed to have both chrp and efika selected?
>
> I think so, yes.

I have then both selected.

I'm sure it is something simple about how I have my kernel configured
wrong but I can't figure out what it is. I have BLK_INITRD turned on.
I can trace in the initrd code and see that it is exiting because
strat_initrd is not set. start_initrd is set in the platform specfic
code which I haven't figured out yet.


>
> Friendly,
>
> Sven Luther
>


-- 
Jon Smirl
jonsmirl@gmail.com
