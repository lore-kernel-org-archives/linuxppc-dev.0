Return-Path: <bigeasy@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A67ADDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 19:43:28 +1000 (EST)
Message-ID: <48DB5D24.7090808@linutronix.de>
Date: Thu, 25 Sep 2008 11:43:00 +0200
From: Sebastian Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] powerpc/boot: add kernel,end node to the cuboot target
References: <200809240124.m8O1O2QK076012@sullivan.realtime.net>
In-Reply-To: <200809240124.m8O1O2QK076012@sullivan.realtime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> On Wed Sep 24 at about 05:54:04 EST 2008, Sebastian Siewior wrote:
>> this could be used by the kexec userland code.
> 
> NACK.
[...]
Thanks for explanation. I just went through the kexec user land code and
saw that the 64bit code uses the device tree to obtain some address and
32bit returns a hard coded struct on game cube (unless it was another
console I mixed it up) and nothing on every other platform. Therefore I
tried to add the missing nodes.

> If you have any questions about kdump or what needs to happen,
> please feel free to contact me either by email or on irc (sometimes
> I use mdm other times the email login as my nick, and when connected
> I tend to leave it well past the hours I am at the computer).
Thanks for the offer.

> 
> milton

Sebastian
