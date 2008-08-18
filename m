Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 05848DE321
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Aug 2008 02:04:40 +1000 (EST)
Received: by gxk14 with SMTP id 14so3634578gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Aug 2008 09:04:39 -0700 (PDT)
Message-ID: <fa686aa40808180857w7e1031den329584b3340d777a@mail.gmail.com>
Date: Mon, 18 Aug 2008 09:57:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfram Sang" <w.sang@pengutronix.de>
Subject: Re: [PATCH V2] MPC52XX: Don't touch pipelining for MPC5200B
In-Reply-To: <20080818141831.GD4282@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080818093132.GA4282@pengutronix.de>
	<200808181249.37220.arnd@arndb.de>
	<20080818141831.GD4282@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 18, 2008 at 8:18 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
> MPC5200 needs to have pipelining disabled for ATA to work. MPC5200B does not.
> So, for the latter, don't touch the original setting from the bootloader.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks Wolfram, I'll pick this one up.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
