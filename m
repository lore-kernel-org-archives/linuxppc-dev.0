Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C019667AC6
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 10:15:31 +1000 (EST)
In-Reply-To: <OFC5EF8ADF.0CD9CACA-ON8725715B.0049AB44-8525715B.0049E2DA@us.ibm.com>
References: <OFC5EF8ADF.0CD9CACA-ON8725715B.0049AB44-8525715B.0049E2DA@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <48DB02C0-2D09-44F6-86AB-28D25FD21796@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: maple_defconfig - CONFIG_ALTIVEC is not set
Date: Wed, 26 Apr 2006 02:15:18 +0200
To: Stephen Winiecki <stevewin@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Is there a reason why ALTIVEC is not enabled in maple_defconfig?
Is it not?  You're kidding me.  [checks] It's not.  Ouch.
Please, Ben or Paul, can you fix this?  Thanks!


Segher

p.s.  I probably should check if it has some more errors /
shortcomings.  But I'm too lazy.  Stephen, do you see anything
else wrong?
