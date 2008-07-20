Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 3AAEDDDEFD
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:13:00 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so309106yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 09:12:59 -0700 (PDT)
Message-ID: <9e4733910807200826m22b676aewa89de8df9fd6da33@mail.gmail.com>
Date: Sun, 20 Jul 2008 11:26:29 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: radeonfb, dedicate memory to something else
In-Reply-To: <48830D56.2080704@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48830D56.2080704@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/20/08, Matt Sealey <matt@genesi-usa.com> wrote:
> Hi guys,
>
>  I know this isn't a PPC question, but since some of the RadeonFB developers
>  live here I thought best (and it's about a PPC platform).
>
>  Is there any way to hack up the RadeonFB driver - or anything related - to
>  reserve portions of the memory for a "fake" MTD or so, and still use the
>  Radeon as a graphics device? What I am talking about basically is turning
>  a 64MB Radeon card into a 32MB Radeon card, or a 128MB one into a 64MB
>  card..

Somebody write this long ago. Maybe around 2000. That's all I
remember. I think they made the video memory into a ram disk.

I believe there is more to it, the GART window may be smaller than the
total RAM on the card. You need to use the GART to map in the
appropriate pieces.

>  I think this can be done by hacking a PCI fixup perhaps, for Efika only
>  in my case, whereby the memory ranges are fiddled.
>
>  Perhaps, a better solution is to use some kind of in-kernel subsystem to
>  "allocate" and return a 32MB segment of PCI memory (and put it in an
>  named rheap) but I assume other drivers can and will simply walk all
>  over it?
>
>  --
>  Matt Sealey <matt@genesi-usa.com>
>  Genesi, Manager, Developer Relations
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
