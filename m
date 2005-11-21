Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 9289A681C2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 22:43:20 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 6DC9229EC6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 12:41:40 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13710-01 for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 12:41:39 +0100 (CET)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 67A8729EBB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 12:41:39 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 21 Nov 2005 13:43:13 +0200
References: <43817ACF.1030903@dgt.com.pl>
In-Reply-To: <43817ACF.1030903@dgt.com.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200511211243.13519.david.jander@protonic.nl>
Subject: Re: Strange results with changing HZ
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 21 November 2005 08:44, Wojciech Kromer wrote:
> My system is:
>  - 2.4.25 kernel from denx.de
>  - uclibc (gcc 3.4.2) + busybox
>  - changed HZ to 1000
>  - rebuild kernel only
>
> AFAIR there souldn't be any need to recompile user apps.

Just an uneducated guess, but are you sure uclibc doesn't depend on HZ at all?
Some things might be just straight syscalls, others might be implemented in 
userspace (inside uclibc)... for example alarm(1) programming an alarm on 
jiffies+1/HZ, and HZ being compiled in from kernel headers ?
I may just be talking rubbish though.

Greetings,

-- 
David Jander
