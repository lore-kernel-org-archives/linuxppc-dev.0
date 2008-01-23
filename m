Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8CDCDDE42
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 03:39:18 +1100 (EST)
Message-Id: <06EE7814-2888-4467-AABF-08458668B2A2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Roman Fietze <roman.fietze@telemotive.de>
In-Reply-To: <200801230839.33212.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: framebuffer swap endianess
Date: Wed, 23 Jan 2008 10:39:04 -0600
References: <323144.65236.qm@web23105.mail.ird.yahoo.com>
	<200801230839.33212.roman.fietze@telemotive.de>
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


On Jan 23, 2008, at 1:39 AM, Roman Fietze wrote:

> Hello ANgelo,
>
> On Tuesday 22 January 2008 16:46:47 Angelo wrote:
>
>> I have just create a framebuffer for an embedded system:
>> - powerpc (little endian)  with  a GPU (big endian).
>
> Are you sure? Isn't it the other way around?

we are sure.  Linux only supports PPC in big endian mode.

  - k
