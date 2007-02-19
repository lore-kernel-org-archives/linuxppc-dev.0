Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 07844DDE36
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 02:03:23 +1100 (EST)
Message-ID: <45D9BC29.5020507@am.sony.com>
Date: Mon, 19 Feb 2007 07:03:05 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC 3/3] zImage: Exception vector support
References: <45D7A914.4040000@am.sony.com>
	<20070218014043.GD1038@crusty.rchland.ibm.com>
In-Reply-To: <20070218014043.GD1038@crusty.rchland.ibm.com>
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
> On Sat, Feb 17, 2007 at 05:17:08PM -0800, Geoff Levand wrote:
>> Add SMP exception vector support to the powerpc zImage bootwrapper.  For
>> platforms which have entry points in the vector table.  This implements
>> SMP entry via the system reset vector.
>> 
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> 
>> ---
>>  arch/powerpc/boot/head.S       |   96 +++++++++++++++++++++++++++++++++++++++++
>>  arch/powerpc/boot/zImage.lds.S |    2 
> 
> This one seems pretty PS3 specific, and there's no makefile entry to actually
> compile it...  Could we name it head_ps3.S or something similar?
> 
> Or am I misunderstanding the code and it's really generic to most SMP
> machines (which would make a case to arguably call it head_smp.S).

No, its not platform specific nor SMP specific, it should work
with all SMP and UP platforms that need this kind of support.

-Geoff
