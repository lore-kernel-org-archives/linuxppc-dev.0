Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4EF7DDE45
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Aug 2007 07:55:39 +1000 (EST)
Message-ID: <46B3A44E.1030508@freescale.com>
Date: Fri, 03 Aug 2007 16:55:26 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: khollan <khollan@daktronics.com>
Subject: Re: BusyBox passwd requires root privileges
References: <11990563.post@talk.nabble.com> <46B395B5.1040009@freescale.com>
	<11991239.post@talk.nabble.com>
In-Reply-To: <11991239.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

khollan wrote:
> 
> 
> Scott Wood-2 wrote:
> 
>>
>>passwd needs to be setuid root.
>>
>>
> 
> How do you do that?

Make sure it's owned by root, and chmod 4755 the binary.  I'm not sure 
how to go about telling busybox to drop suid when invoked as something 
else.  It'd probably be better to build two busyboxes, one with all suid 
commands and the other with the rest.

-Scott
