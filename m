Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw4.extranet.thmulti.com (dmzraw4.extranet.thmulti.com
	[141.11.234.72]) by ozlabs.org (Postfix) with ESMTP id 03F81681B8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 00:17:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Floating point math in kernel interrupt -- am I doing this
	right?(repost)
Date: Mon, 6 Feb 2006 13:57:35 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2F76@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: <linuxppc-embedded@ozlabs.org>
Cc: Jeremy Friesner <jaf@lcsaudio.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
>> So my question is, is there some minor detail that my=20
>> FPU-state-save/restore
>> code is missing, that would cause these sort of symptoms?
>
>Just get all of this out of the kernel.  If you used the standard ALSA
>drivers and framework, lots of mixing features are available to you.
>If you need some custom mixing, just write a plug-in to do it.
>Your data rates are so low they don't justify making any hacks
>like this.

.. or if you *do* need hard-realtime feedback, you may consider
using Xenomai[1] (formerly known as RTAI/Fusion) instead of=20
a hack of the interrupt handler. Thanks to this nice project,=20
FPU on PQ2 works fine in kernel-land, and if need be, it will=20
let you move to user-land seamlessly while keeping the constraints.
Feel free to join the xenomai-help mailing list to get more help=20
on specific questions. Disclaimer: I'm not affiliated with Xenomai,
I am just a happy user :-)

[1] http://xenomai.org


Regards,
--=20
Stephane
