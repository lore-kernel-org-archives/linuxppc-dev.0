Return-Path: <rmcguire@uwbt.com>
Received: from mail19c.g19.rapidsite.net (mail19c.dulles19-verio.com
	[204.202.242.56]) by ozlabs.org (Postfix) with SMTP id 763A0689AE
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 06:21:21 +1100 (EST)
Received: from mx32.stngva01.us.mxservers.net (204.202.242.10)
	by mail19c.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id 4-08496964
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 14:21:18 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Voyager Video support color depths?
Date: Tue, 7 Feb 2006 11:20:50 -0800
Message-ID: <002b01c62c1b$a0152fc0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.294.1139321937.857.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Everyone,

I had a question about the various video support that has been tested with
the 2.4.25 DENX Kernel.

To date I have had pretty good luck with by making sure I have compiled the
kernel with the Voyager.h file set at 32 BPP mode.

For speed optimization I wanted to cut it back to 16 BPP mode, however I
couldn't hardly get it to boot the machine after I did this change by
changing '#define SCREEN_BPP 16'. Most attempts the kernel would lock up
before a login prompt was available. When I tried SCREEN_BPP at 8 then it
booted fine, however QT/Embedded had terrible colors.

I was wondering if I should be looking for the trouble in some other code,
or perhaps hardware, or if this is a known bug in the SM501 / Voyager
driver, or perhaps the linux frame buffer driver.

Thanks all,

-Russ
