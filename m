Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EE46FDDF24
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 08:21:52 +1000 (EST)
Message-ID: <481B93F9.80700@am.sony.com>
Date: Fri, 2 May 2008 15:21:45 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC] [PATCH] vmemmap fixes to use smaller pages
References: <1209534108.18023.221.camel@pasglop>	
	<481A3A50.3060101@am.sony.com> <1209681590.18023.295.camel@pasglop>
In-Reply-To: <1209681590.18023.295.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-05-01 at 14:46 -0700, Geoff Levand wrote:
>> 
>> It doesn't seem to cause problems on PS3, and I added it into
>> ps3-linux.git
>> as other/powerpc-vmemmap-variable-page-size.diff, but I couldn't get
>> it to
>> fail without the patch...
>>  
>> Could you send me your kernel .config?
> 
> ps3_defconfig with added vmmemap (which is disabled by default).

Well, it seems that it wasn't that I couldn't get it to fail, but
that it always fails.  add_memory() doesn't work anymore, with or
without vmmemap.

I'll look at it more next week.

-Geoff
