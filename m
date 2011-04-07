Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 2F87FB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 21:33:57 +1000 (EST)
Date: Thu, 7 Apr 2011 13:33:47 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: Revert 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?
Message-ID: <20110407113347.GA2237@iram.es>
References: <20110404235259.GA30132@iram.es>
	<20110406084101.GB13963@pengutronix.de>
	<BANLkTimAJ-s_3A3L1YGfoFLmd4bpu2jWVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTimAJ-s_3A3L1YGfoFLmd4bpu2jWVA@mail.gmail.com>
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Hi Dave,

sorry, in my previous message I forgot the strace
output, which is an inifinite loop of the following:

--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
ioctl(7, 0xc0286429, 0xffdf9bb8)        = -1 EBUSY (Device or resource busy)
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
ioctl(7, 0xc0286429, 0xffdf9bb8)        = -1 EBUSY (Device or resource busy)

Note: fd 7 is /dev/dri/card0.

	Regards,
	Gabriel
