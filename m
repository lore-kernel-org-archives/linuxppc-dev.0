Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE1DCDDEB6
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 10:10:28 +1000 (EST)
In-Reply-To: <20070426203802.GC17302@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<200704261055.33739.arnd@arndb.de>
	<20070426164835.GA14149@lixom.net>
	<200704261911.22553.arnd@arndb.de>
	<c8fb6a47d8be41f856ab9cf19fc3814d@kernel.crashing.org>
	<20070426203802.GC17302@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f30b4e9138137515cafc0276d93812e0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] [2.6.22] pasemi: cpufreq driver
Date: Fri, 27 Apr 2007 02:10:21 +0200
To: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, egor@pasemi.com,
	Arnd Bergmann <arnd@arndb.de>, cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> You probably should map the SDC registers in the
>> platform startop code, and then have the various
>> platform drivers use that.  Maybe even do an
>> abstraction ;-)
>
> Yep, it's a good idea to do and I'll look at it for 2.6.23 time frame.

Oh I'm sure you can get that done in time for .22 still ;-)


Segher
