Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58FDA67A80
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 06:02:00 +1100 (EST)
In-Reply-To: <20050126185350.20232.qmail@web53804.mail.yahoo.com>
References: <20050126185350.20232.qmail@web53804.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BD936D78-6FCC-11D9-A0FB-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 26 Jan 2005 11:01:52 -0800
To: annamaya <annamaya@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Is there a DER for the MPC82xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 26, 2005, at 10:53 AM, annamaya wrote:

> Can someone tell me if the BDI will be able to catch
> all different kinds of exceptions/interrupts on the
> MPC82xx without requiring any special register
> programming? I am unable to find anything that that
> resembles the DER register on the MPC8280.

The BDI2000 works very nicely on 82xx processors.
The 82xx debug unit is the standard COP interface,
completely different from the 8xx debug interface.
Stop looking for a DER on the 82xx, plug in the
BDI2000 and use it.  Make sure you understand all
of the features of the BDI2000, as even on the 8xx
you should not be worrying about the DER. Let the
BDI2000 configure all of that accordingly based upon
what you are asking it to do.


	-- Dan
