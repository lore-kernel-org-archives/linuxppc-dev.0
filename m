Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 04EC868458
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Oct 2005 19:16:30 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 3578829EC9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Oct 2005 11:14:53 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20065-07 for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Oct 2005 11:14:52 +0200 (CEST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 8718929EC6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Oct 2005 11:14:52 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 5 Oct 2005 11:16:20 +0200
References: <OF3208D35D.AA3CBB6C-ON48257090.0019F4B3@uk.marconicomms.com>
	<200510041711.34388.david.jander@protonic.nl>
	<43429CBA.6050906@ru.mvista.com>
In-Reply-To: <43429CBA.6050906@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510051116.21756.david.jander@protonic.nl>
Subject: Re: serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 04 October 2005 17:16, Vitaly Bordug wrote:
> Yes, but PQ2FADS use cpm_uart and hence the commandline should be
> console=ttyCPM0,115200

You are totally right. I did that same mistake once in the past and again now. 
Shame on me ;-)
Now that I remeber, this might give trouble if you happen to use a normal uart 
(16550 or similar) also, and devfs. I had to slightly hack serial.c in my 
version of the kernel for this combination to work. I don't remeber right now 
exactly what I did, but it had to do with "SERIAL_DEV_OFFSET" and major/minor 
numbers ;-)
Anyway, I don't think your board has this combination.

Greetings,

-- 
David Jander
