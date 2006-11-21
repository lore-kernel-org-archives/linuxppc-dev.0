Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 24CA467C58
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 06:54:23 +1100 (EST)
Message-ID: <45635967.5020000@am.sony.com>
Date: Tue, 21 Nov 2006 11:54:15 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
References: <4554DACB.8060809@am.sony.com>
	<4559099A.6060805@am.sony.com>	<17762.26999.152198.792581@cargo.ozlabs.ibm.com>	<200611211111.12882.arnd@arndb.de>	<Pine.LNX.4.62.0611211114220.21124@pademelon.sonytel.be>	<17762.59947.937875.546225@cargo.ozlabs.ibm.com>
	<20061121132253.GA17530@lst.de>
In-Reply-To: <20061121132253.GA17530@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Olof Johansson <olof@lixom.net>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Tue, Nov 21, 2006 at 10:59:39PM +1100, Paul Mackerras wrote:
>> Geert Uytterhoeven writes:
>> 
>> > Indeed, and since we don't like changing all of these back and forth, it would
>> > be nice to have a definitive decision soon.
>> 
>> Put the ps3 support in arch/powerpc/platforms/ps3.  If there are
>> hypervisor-specific routines, they can have a ps3pf_ prefix if you
>> want.
> 
> The whole port is hypervisor-specific.  It should be called ps3hv or
> sonyhv (in case the plan for more hardware that's crippled by this
> hypervisor)  ps3 should be left for a bare metal port that people may
> or may not do when they have time at their hands to get rid of the
> HV that cripples the hardware.


I don't see an iserieshv, or pserieshv, or an ibmhv, or a powermacof.  I
don't think this platform should be treated any differently.  

As Paul and others requested, I will use 'platforms/ps3'.  I think that
is most natural and is what would be expected by almost all users.  I
don't think anyone can convincingly argue that ps3 is not an acceptable
name for this platform.

I will change all ps3pf references in the source to ps3, but will retain
the current HV (lv1) call interface.  I'll post a new set of patches with
these changes, plus a few more to better support multi-platform
(IBM Blade + PS3) soon.

-Geoff

 
