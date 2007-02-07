Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5F069DDF07
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 04:04:43 +1100 (EST)
Message-ID: <45CA069F.7060108@am.sony.com>
Date: Wed, 07 Feb 2007 09:04:31 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 3/3] PS3: System manager support
References: <45C8FFF7.7090805@am.sony.com>
	<Pine.LNX.4.62.0702071527350.29060@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0702071527350.29060@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On Tue, 6 Feb 2007, Geoff Levand wrote:
>> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
>> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
>> @@ -42,6 +42,10 @@
>>  #define DBG(fmt...) do{if(0)printk(fmt);}while(0)
>>  #endif
>>  
>> +#if !defined(CONFIG_SMP)
>> +static void smp_send_stop(void) {}
>> +#endif
> 
> Shouldn't this be added to include/linux/smp.h instead? That header file
> already contains some dummy definitions for the non-SMP case.

Sounds like a good idea.  I'll prepare a seperate patch that does it.

-Geoff
