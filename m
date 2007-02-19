Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 853B1DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:39:48 +1100 (EST)
Message-ID: <45DA1919.7010706@am.sony.com>
Date: Mon, 19 Feb 2007 13:39:37 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC 3/3] zImage: Exception vector support
References: <45D7A914.4040000@am.sony.com>	
	<20070218014043.GD1038@crusty.rchland.ibm.com>	
	<45D9BC29.5020507@am.sony.com>
	<1171920901.24204.55.camel@zod.rchland.ibm.com>
In-Reply-To: <1171920901.24204.55.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Mon, 2007-02-19 at 07:03 -0800, Geoff Levand wrote:
>> Josh Boyer wrote:
>> > On Sat, Feb 17, 2007 at 05:17:08PM -0800, Geoff Levand wrote:
>> >> Add SMP exception vector support to the powerpc zImage bootwrapper.  For
>> >> platforms which have entry points in the vector table.  This implements
>> >> SMP entry via the system reset vector.
>> >> 
>> >> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> >> 
>> >> ---
>> >>  arch/powerpc/boot/head.S       |   96 +++++++++++++++++++++++++++++++++++++++++
>> >>  arch/powerpc/boot/zImage.lds.S |    2 
>> > 
>> > This one seems pretty PS3 specific, and there's no makefile entry to actually
>> > compile it...  Could we name it head_ps3.S or something similar?
>> > 
>> > Or am I misunderstanding the code and it's really generic to most SMP
>> > machines (which would make a case to arguably call it head_smp.S).
>> 
>> No, its not platform specific nor SMP specific, it should work
>> with all SMP and UP platforms that need this kind of support.
> 
> Well, I'm not sure it will work with all UP platforms anyway.  The SPR
> you're peeking at to look at the thread number doesn't even exist on 4xx
> for example.

The 4xx wrapper needs a reset vector?  If so, what bootloader are you using?

-Geoff
