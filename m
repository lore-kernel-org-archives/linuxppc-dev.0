Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07374DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 02:10:39 +1000 (EST)
Message-ID: <46FBD483.6090403@freescale.com>
Date: Thu, 27 Sep 2007 11:04:19 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Is it safe to use these Linux function (test_bit(), set_bit(),
	clear_bit()) in character device driver for 2.6.10 ppc kernel.
References: <12916782.post@talk.nabble.com>
In-Reply-To: <12916782.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Misbah khan wrote:
> Hi all I am using "test_bit(),set_bit(),clear_bit() etc" API functions 
> provided by the Linux kernel. I want to know that if anybody is used it 
> and have full faith in its operation then please let me know. Driver in 
> the while loop is calling these API's hence i want to make sure that its 
> operation will remain stable.

They're used all over the place.  Is there anything about them that you 
find suspect?

-Scott
