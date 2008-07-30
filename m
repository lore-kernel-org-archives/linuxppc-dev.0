Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D1B32DE0A7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 22:00:19 +1000 (EST)
Date: Wed, 30 Jul 2008 14:00:06 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Subject: Re: Warning: Uable to open an inital console
In-Reply-To: <f234e2140807300214v60a2ddf3s59c1c9c47af30c9b@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0807301358550.1993@vixen.sonytel.be>
References: <f234e2140807300214v60a2ddf3s59c1c9c47af30c9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-2079314093-1217419206=:1993"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-2079314093-1217419206=:1993
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 30 Jul 2008, Vijay Nikam wrote:
> I have mpc8313erdb board and trying boot the kernel from NAND flash ...
> The kernel is booting fine but it hangs at the following message;
> 
> Warning: unable to open an initial console.

Your root file system doesn't have /dev/console, which should look like:

| crw------- 1 root dialout 5, 1 2008-07-30 10:21 /dev/console

> Kernel panic - not syncing: No init found.  Try passing init= option to
> kernel.

Your root file system doesn't have init (/sbin/init, /init, ...).

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@eu.sony.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis 293-0376800-10 GEBA-BE-BB
---584349381-2079314093-1217419206=:1993--
