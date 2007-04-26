Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85335DDF62
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 00:36:25 +1000 (EST)
In-Reply-To: <571811.46559.qm@web8406.mail.in.yahoo.com>
References: <571811.46559.qm@web8406.mail.in.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <62586E6D-6D9F-4D65-9BCC-772BC35599F1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8544 Watchdog Timer
Date: Thu, 26 Apr 2007 09:35:28 -0500
To: vinay hegde <thisismevinay@yahoo.co.in>
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


On Apr 26, 2007, at 3:43 AM, vinay hegde wrote:

> Hi,
>
> I am working with Freescale MPC8544E board. I need an
> information related to the functionality of hardware
> watchdog provided by MPC8544 processor.
>
> Here is the question:
>
> On watchdog timeout, whether the CPU can reset itself
> _or_ does it assert a hardware HRESET_REQ signal to
> some external hardware requesting for reset?
>
> Please let me know the inputs.

This a question best asked to Freescale support. However, I believe  
the processor will end up asserting HRESET_REQ and expects external  
board logic to reset things.

The processor core will reset itself as part of this process.

- k
