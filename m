Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id DED54DDEC2
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 07:14:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so506382anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 12:14:21 -0800 (PST)
Message-ID: <fa686aa40801211214u31581036m2ea2cf11d82c3f75@mail.gmail.com>
Date: Mon, 21 Jan 2008 13:14:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
In-Reply-To: <200801211201.41142.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121103434.397382000@sunsite.dk>
	<200801211201.41142.david-b@pacbell.net>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/21/08, David Brownell <david-b@pacbell.net> wrote:
> On Monday 21 January 2008, Peter Korsgaard wrote:
> > The Cypress c67x00 (EZ-Host/EZ-OTG) controllers are multi-role low/fullspeed
> > USB controllers. This patch series implements a HCD driver and shows the
> > work-in-progress status of a gadget driver.
> >
> > I believe patch 1..3 are ready, and I would like to see queued up for 2.6.25.
> >
> > Changes since v3:
> > - Lots of cleanups: checkpatch, interrupt handling, c67x00_ prefixes, ..
> > - The dummy platform_device's created per serial engine are gone.
> > - Gadget driver (WIP)
> >
> > Comments are very much appreciated.
>
> How does this relate to the "v3" patches posted 8-Jan by Grant Likely?
> Is that the "v3" you were referring to?

My v1, v2 and v3 postings were based on Peter's work from about a year
ago.  I picked up the driver because Peter didn't have any time to
work on it.

Peter told me last week that this series merges the v3 patches with
work that he's done recently now that he has some time to do so again.
 However, I don't know what the diff is between v3 and this new
series.  I've also not done a full review, so I cannot make any
comment at this time.

Personally, I'd prefer to see the v3 series picked up now (as I
believe all outstanding comments from the list have been addressed)
and have new patches build on top of that, but that's just my
preference.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
