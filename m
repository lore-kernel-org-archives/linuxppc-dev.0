Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 5DD7EDDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 08:13:54 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so960798uge.0
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 13:13:52 -0800 (PST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
References: <20080121103434.397382000@sunsite.dk>
	<200801211201.41142.david-b@pacbell.net>
	<fa686aa40801211214u31581036m2ea2cf11d82c3f75@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 21 Jan 2008 22:13:49 +0100
In-Reply-To: <fa686aa40801211214u31581036m2ea2cf11d82c3f75@mail.gmail.com>
	(Grant Likely's message of "Mon\, 21 Jan 2008 13\:14\:21 -0700")
Message-ID: <87bq7e286q.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> My v1, v2 and v3 postings were based on Peter's work from about a year
 Grant> ago.  I picked up the driver because Peter didn't have any time to
 Grant> work on it.

Ack.

 Grant> Peter told me last week that this series merges the v3 patches with
 Grant> work that he's done recently now that he has some time to do so again.
 Grant>  However, I don't know what the diff is between v3 and this new
 Grant> series.  I've also not done a full review, so I cannot make any
 Grant> comment at this time.

I would be grateful if you would find a bit of time to skim over it -
I'll post a diff between v3 and v4-without-the-gadget-part in a
moment.

 Grant> Personally, I'd prefer to see the v3 series picked up now (as I
 Grant> believe all outstanding comments from the list have been addressed)
 Grant> and have new patches build on top of that, but that's just my
 Grant> preference.

That's understandable; I would ofcause prefer to see v4 selected instead
to get the cleanups and fixes and because the in-progress gadget work
is based on it.

But anyway, that's details - Most of all I would like to see c67x00
support in mainline, one way or another. Most of the work has been
sitting on my hard drive gathering dust since spring 2006.

-- 
Bye, Peter Korsgaard
