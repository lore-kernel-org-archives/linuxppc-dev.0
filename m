Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C2C5679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 11:22:04 +1000 (EST)
In-Reply-To: <8E342283C2100540AAC5D1030970547766F7B1@rcexc.racoms.loc>
References: <8E342283C2100540AAC5D1030970547766F7B1@rcexc.racoms.loc>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6b2464f619ef5e336557fea3db91d42a@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 15 Jun 2005 21:21:56 -0400
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.4.26 and MPC885 context switching time
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 15, 2005, at 11:43 AM, Schaefer-Hutter, Peter wrote:

> I basically used the two programs from
> http://www.ibm.com/developerworks/linux/library/l-rt9/

That's a fine test, if you run it on various systems and
compare the _relative_ results.  There is more than
context switching going on here.

.... there aren't any MMU "problems" with the 8xx, it's
likely to be the most efficient implementation of all
systems that use software to support the MMU.  The
processor in general is very sensitive to many system
architecture decisions, especially the system bus
and DRAM configuration.  Make certain you really
understand what you have configured and how the
tests you run are affected by that.

Thanks.


	-- Dan
