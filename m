Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 704F9DE49E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 23:37:15 +1000 (EST)
Date: Sat, 19 Apr 2008 15:36:58 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] mpc5200: Switch mpc5200 dts files to dts-v1
	format
Message-ID: <20080419133658.GJ13814@pengutronix.de>
References: <20080418160812.11897.5654.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20080418160812.11897.5654.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Sascha Hauer <sha@pengutronix.de>, m8@semihalf.com,
	Wolfram Sang <wsa@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 09:10:04AM -0700, Grant Likely wrote:
> Update dts files to current format

Is it somehow possible that this device tree stuff is *not* changed over
and over again and break everything out there? When people have not even
agreed on basic things like decimal vs. hex numbers, the whole idea
should be developed out-of-tree, then stabilize and *then* be submitted
to the Linux mainline.

Is it also really necessary to change like "gpt" vs. "timer" and "pic"
vs. "interrupt-controller" all the time? If you compare the last
mainline kernels, each one got a fundamental change in the naming, each
time breaking anyone who doesn't have his stuff in the mainline yet.

Sorry, but this is simply annoying, and the whole "the only thing we
have to do is to define it once and be done then" is crap.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
