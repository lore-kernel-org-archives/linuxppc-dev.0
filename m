Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id C2669DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 08:08:09 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so959876uge.0
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 13:08:08 -0800 (PST)
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
References: <20080121103434.397382000@sunsite.dk>
	<200801211201.41142.david-b@pacbell.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 21 Jan 2008 22:08:04 +0100
In-Reply-To: <200801211201.41142.david-b@pacbell.net> (David Brownell's
	message of "Mon\, 21 Jan 2008 12\:01\:40 -0800")
Message-ID: <87fxwq28gb.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David Brownell <david-b@pacbell.net> writes:

Hi,

 David> How does this relate to the "v3" patches posted 8-Jan by Grant Likely?
 David> Is that the "v3" you were referring to?

Yes - Sorry, I should have been more clear about that.

 David> It's confusing to see two different people submit two sets of
 David> patches for the same driver, without any evident
 David> coordination...

True. The story behind it is that I posted the original patch series
back in Spring '06, but real life got in way of me following up on
pushing it to mainline (some development was still done on it, and
we've shipped it in products).

Then Grant picked it up (which I'm grateful for) and posted his v1..v3
series. I have now taken his v3 series and merged it with my
development.

-- 
Bye, Peter Korsgaard
