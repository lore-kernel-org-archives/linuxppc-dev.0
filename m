Return-Path: <Tom.Ziomek@motorola.com>
Received: from motgate2.mot.com (motgate2.mot.com [144.189.100.101])
	by ozlabs.org (Postfix) with ESMTP id C0A1B67C48
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Aug 2006 05:18:11 +1000 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate2.mot.com (8.12.11/Motorola) with ESMTP id k7PJI5Yf002678
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 12:18:05 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by az33exr03.mot.com (8.13.1/8.13.0) with ESMTP id k7PJI3gC025711
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 14:18:04 -0500 (CDT)
Date: Fri, 25 Aug 2006 14:18:03 -0500 (Central Daylight Time)
From: T Ziomek <ctz001@email.mot.com>
To: Claus Gindhart <claus.gindhart@kontron.com>
Subject: RE: "ip=" command line strangeness...
In-Reply-To: <DADA32856852FC458E0F96B664A6F55E011E2425@kom-mailsrv1.kontron-modular.com>
Message-ID: <Pine.WNT.4.61.0608251400100.200@holyoke.labs.mot.com>
References: <DADA32856852FC458E0F96B664A6F55E011E2425@kom-mailsrv1.kontron-modular.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> please provide the ip-commandline in the full-size format
> ip=<my ip>:<server ip>:<host ip>:<net mask>:<hostname>:<which ethernet port, e.g. "eth0">

The port should be followed by ":<autoconf>", right?  I'm basing that on 
Documentation/nfsroot.txt .

> I assume, that this will fix your problem

Meh...that string is so bloody long I don't want to bother trying it since
I know that "ip=<my IP>:gibberish" works well enough...

Somebody else suggested "ip=<my IP> off"; that had no effect.  Neither did 
"ip=<my IP>::::::" or "ip=<my IP>::::::off" (which I have successfully
used with 2.4).

I'm just going to stick with my silly workaround.  Thanks to all for the
suggestions though.
Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
