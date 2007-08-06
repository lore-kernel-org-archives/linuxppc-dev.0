Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4911CDDED6
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 09:12:13 +1000 (EST)
In-Reply-To: <200708070034.19193.m.kozlowski@tuxland.pl>
References: <20070731230932.a9459617.akpm@linux-foundation.org>
	<200708062134.16643.m.kozlowski@tuxland.pl>
	<236b147ed4a92945baa3c6b29e7e5f31@kernel.crashing.org>
	<200708070034.19193.m.kozlowski@tuxland.pl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <14f932ea857d563d409cc10b570fc085@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.23-rc1-mm2
Date: Tue, 7 Aug 2007 01:12:00 +0200
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It seems like things go wrong when lparmap.s is generated with
>> (DWARF) debug info; could you try building it (manually) with -g0
>> added on the end of the compile line, and see if head_64.o compiles
>> okay for you then?  If so, I'll prepare a proper patch for it, I
>> have a similar one (also for lparmap!) in my queue already...
>
> Ok it worked. I had to add -g0 to Makefile under arch/powerpc/kernel 
> because
> -g0 was added before -g and didn't have any effect when adding to 
> Makefile
> in top dir.

Yeah, that's why I said "build lparmap.s manually" :-)

> But yes - it compiles now.

Great, I'll combine it with my other lparmap build patch then.
Thanks for the report and testing!


Segher
