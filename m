Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AFCF7DDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 03:57:49 +1100 (EST)
Message-ID: <45F82982.2020509@am.sony.com>
Date: Wed, 14 Mar 2007 09:57:38 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch] PS3: Fix hardware watchpoints
References: <45F74D69.5070600@am.sony.com>
	<17911.24243.64287.434769@cargo.ozlabs.ibm.com>
	<200703141730.15344.arnd@arndb.de>
In-Reply-To: <200703141730.15344.arnd@arndb.de>
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

Arnd Bergmann wrote:
> On Wednesday 14 March 2007, Paul Mackerras wrote:
>> Geoff Levand writes:
>> 
>> > Add PS3 support for the PowerPC processor's Data Address Breakpoint
>> > Register (DABR).
>> > 
>> > Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
>> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> > 
>> > ---
>> > Paul, please consider for 2.6.21.
>> 
>> It's nice and small, but it isn't really a bugfix as far as I can
>> see...  What's the downside of it not going into 2.6.21, apart from
>> some inconvenience in debugging things?
> 

...

> Maybe it's better to just queue them for 2.6.22 now, independent
> of the severity of bugs fixed by a given patch.

It doesn't matter so much, that's why I just said to consider for
2.6.21.

Paul, please just add to your for-2.6.22 branch.

-Geoff
