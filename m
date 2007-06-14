Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D9ACADDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 03:05:16 +1000 (EST)
Message-ID: <46717542.3000705@am.sony.com>
Date: Thu, 14 Jun 2007 10:05:06 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 29/30 v2] PS3: Device tree source.
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com> <46709A76.4000602@am.sony.com>
	<Pine.LNX.4.62.0706140954540.26873@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0706140954540.26873@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On Wed, 13 Jun 2007, Geoff Levand wrote:
>> Subject: PS3: Device tree source.
>> 
>> The PS3 device tree source.
>> 
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> ---
>> 
>> ver2: Here's an updated version based on the discussions.
> 
> This one doesn't seem to work. The kernel hangs very early in the boot process.
> I haven't digged into it yet to find out why.

The trouble was not in this patch, but that I didn't update
ps3-legacy-bootloader-hack.diff to match this change.  I
committed an update to my git repositories on kernel.org.

Sorry if this inconvenienced anyone.

-Geoff 
