Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 632B867B22
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Nov 2006 17:01:45 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	kAJ6Fllt019452 for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Nov 2006 23:15:47 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kAJ61fi1013863
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Nov 2006 00:01:42 -0600 (CST)
Subject: Re: memory corruption after MMU turned on
From: Dave Liu <r63238@freescale.com>
To: Lei Sun <leisun124@gmail.com>
In-Reply-To: <f9a7e7a80611181353p21dce384m21f30bc9d8935a8d@mail.gmail.com>
References: <f9a7e7a80611160744t7071ff6clf5e1d42cfaa2c856@mail.gmail.com>
	<1163753324.3655.18.camel@localhost.localdomain>
	<f9a7e7a80611170847n7a19073fief69dede52d1c199@mail.gmail.com>
	<1163844232.3659.15.camel@localhost.localdomain>
	<f9a7e7a80611181353p21dce384m21f30bc9d8935a8d@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 14:01:42 +0800
Message-Id: <1163916102.3655.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-18 at 16:53 -0500, Lei Sun wrote:
> I tried enable i-cache, but it looks fine, however if i enable

Okay, That means the burst read memory is right. I think you should
check the code at the else, not only focus on RFI. Maybe the problem is
at the else position. When kernel boot stop, can not see any more
printed message, you can attach to the process with CW and USBTAP. see
where the current program pointer is.

> d-cache, u-boot corrupted right away, debugger showed some garbage
> memory instead of valid instruction.
<snip>
