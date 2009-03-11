Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 74880DE204
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 04:26:14 +1100 (EST)
Date: Wed, 11 Mar 2009 18:26:12 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH 0/7] Generic RTC class driver
In-Reply-To: <20090311154505.GB5448@bombadil.infradead.org>
Message-ID: <alpine.LRH.2.00.0903111825040.1040@vixen.sonytel.be>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<alpine.LRH.2.00.0903111134270.1040@vixen.sonytel.be>
	<20090311154505.GB5448@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linux-m68k@vger.kernel.org,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi Kyle,

On Wed, 11 Mar 2009, Kyle McMartin wrote:
> On Wed, Mar 11, 2009 at 11:36:02AM +0100, Geert Uytterhoeven wrote:
> > Is it OK for you to take it through your PA-RISC tree?
> > If yes, I can resend the patch series with the collected acks.
> 
> That's fine with me, just hit me up with a git tree address and I'll
> suck it all into the rtc-parisc tree?

I put it up at:

master.kernel.org:/pub/scm/linux/kernel/git/geert/linux-rtc-generic.git

The master branch should be a descendant of your rtc-parisc branch.

Thanks!

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
