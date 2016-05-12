Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5QCY5C2XzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 06:52:08 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: John Youn <John.Youn@synopsys.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Thu, 12 May 2016 22:50:54 +0200
Message-ID: <5000683.B2NcB5DoK5@wuerfel>
In-Reply-To: <50455529.fZie4vOnRh@debian64>
References: <4231696.iL6nGs74X8@debian64> <5734CE1C.8070208@synopsys.com>
 <50455529.fZie4vOnRh@debian64>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 12 May 2016 22:39:36 Christian Lamparter wrote:
> On Thursday, May 12, 2016 11:40:28 AM John Youn wrote:
> > On 5/12/2016 6:30 AM, Christian Lamparter wrote:
> > > On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
> > >>
> > >> If I recall correctly, the rough consensus was to go with your longer
> > >> patch in the future (fixed up for the comments that BenH and
> > >> I sent), and I'd suggest basing it on top of a fixed version of
> > >> my patch.
> > > Well, but it comes with the "overhead"! So this was just as I said:
> > > "Let's look at it and see if it's any good"... And I think it isn't
> > > since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
> > > archs etc...
> > 
> > I slightly prefer the more general patch for future kernel versions.
> > The overhead will probably be negligible, but we can perform some
> > testing to make sure.
> > 
> > Can you resubmit with all gathered feedback?
> Yes I think I can do that. But I would really like to get the
> regression out of the way. So for that: I back Arnd's patch.
> It explains the problem much better and doesn't kill MIPS 
> like the revert I was doing in my initial post to the MLs.
> Also, another bonus: his patch is suited to port to stable.
> 
> The auto-detection approach is not that easy to get right,
> given all the stuff that's going on with BE8, LE4, ... So
> can we have your "blessing" for Arnd's patch for now? since
> that way, I can base my patch on top of his work about the
> issues of endiannes? (Just say: ACK  )
> 
> Arnd: do you have a version with the #ifdef lower/uppercase
> fix? Or should I give it a try (and fail in a different way  )

I've already fixed it up locally, will send the latest version
so it's out there, whether Felipe takes it or not.

	Arnd
