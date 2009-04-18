Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A45F5DE08A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 14:37:48 +1000 (EST)
Date: Sat, 18 Apr 2009 00:37:45 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Trent Piepho" <xyzzy@speakeasy.org>
Subject: Re: [PATCH] powerpc: Update Warp to use leds-gpio driver
Message-ID: <20090418003745.7dce8f47@lappy.seanm.ca>
In-Reply-To: <Pine.LNX.4.64.0904172008310.5178@t2.domain.actdsltmp>
References: <20090406175825.76bb969c__7633.03726348585$1239055251$gmane$org@lappy.seanm.ca>
	<Pine.LNX.4.64.0904172008310.5178@t2.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 17 Apr 2009 20:12:50 -0700 (PDT)
"Trent Piepho" <xyzzy@speakeasy.org> wrote:

> On Mon, 6 Apr 2009, Sean MacLennan wrote:
> > Now that leds-gpio is a proper OF platform driver, the Warp can use
> > the leds-gpio driver rather than the old out-of-kernel driver.
> >
> > One side-effect is the leds-gpio driver always turns the leds off
> > while the old driver left them alone. So we have to set them back to
> > the correct settings.  
> 
> Originally, I had the OF bindings support this feature, see
> http://article.gmane.org/gmane.linux.kernel/749094
> 
> Maybe this would be a better way to do it?  It avoids the glitch in
> the leds, is less code overall, and can be use by other devices that
> might want this same behavior.

Yes, that is a cleaner way to handle the LEDs. Do you know why this
patch wasn't accepted at the time? A quick google shows that Grant
Likely acked it.

The patch will no longer apply since default state does not exist.

Cheers,
   Sean
