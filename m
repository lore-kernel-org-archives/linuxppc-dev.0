Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 50A9567A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 12:33:16 +1100 (EST)
Message-ID: <4223C656.8000201@mvista.com>
Date: Mon, 28 Feb 2005 18:33:10 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Ron Bianco <ronb@lcsaudio.com>
References: <NCBBJPCHJLKAEAHINDCEGEJFFMAA.ronb@lcsaudio.com>
In-Reply-To: <NCBBJPCHJLKAEAHINDCEGEJFFMAA.ronb@lcsaudio.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: linuxppc tree with mv64xxx included?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ron Bianco wrote:

>I'm trying to locate the correct bitkeeper or other URL to get access to a
>linux 2.5 or 2.6 tree that includes the support for the marvell mv64xxx
>series chips.
>I've examined the emails in this list regarding related patches for clues,
>but am still confused.
>
>Tried bk://ppc.bkbits.net/linuxppc-2.5, but there is no marvell code.
>

Its in there along with a couple boards that use it.  Note that the core 
code is in arch/ppc/syslib in 2.6.  The name of the main core file is 
mv64x60.c.

There are also several patches sitting in the mm tree waiting to go in.  
One of those patches adds an i2c driver.

Mark
