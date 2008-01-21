Return-Path: <david-b@pacbell.net>
Received: from smtp122.sbc.mail.sp1.yahoo.com (smtp122.sbc.mail.sp1.yahoo.com
	[69.147.64.95]) by ozlabs.org (Postfix) with SMTP id 18953DDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 07:01:44 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
Date: Mon, 21 Jan 2008 12:01:40 -0800
References: <20080121103434.397382000@sunsite.dk>
In-Reply-To: <20080121103434.397382000@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801211201.41142.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 January 2008, Peter Korsgaard wrote:
> The Cypress c67x00 (EZ-Host/EZ-OTG) controllers are multi-role low/fullspeed
> USB controllers. This patch series implements a HCD driver and shows the
> work-in-progress status of a gadget driver.
> 
> I believe patch 1..3 are ready, and I would like to see queued up for 2.6.25.
> 
> Changes since v3:
> - Lots of cleanups: checkpatch, interrupt handling, c67x00_ prefixes, ..
> - The dummy platform_device's created per serial engine are gone.
> - Gadget driver (WIP)
> 
> Comments are very much appreciated.

How does this relate to the "v3" patches posted 8-Jan by Grant Likely?
Is that the "v3" you were referring to?

It's confusing to see two different people submit two sets of patches
for the same driver, without any evident coordination...

- Dave
