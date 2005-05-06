Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA320679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 03:46:04 +1000 (EST)
In-Reply-To: <20050506173246.GD19401@gate.ebshome.net>
References: <427B22A0.8010704@ru.mvista.com>
	<20050506081805.GA19401@gate.ebshome.net>
	<427B3465.1070502@ru.mvista.com>
	<20050506170809.GC19401@gate.ebshome.net>
	<7ad6626ea88c1e1ec98d310f4db438f7@embeddededge.com>
	<20050506173246.GD19401@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1ee36950a2147d4208cf9af575be7478@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 6 May 2005 13:45:58 -0400
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2] Updated platform additions for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 6, 2005, at 1:32 PM, Eugene Surovegin wrote:

> Yeah, I think 3 parameters approach is OK. IOCTL handlers are made
> like this and so far they proved to be quite flexible.

I thought we also discussed placing the PHY irq numbers in the
platform data structure at one time? :-)  Of course, we still need
the feature_call to do any routing of the signal that may be required.

Thanks.

	-- Dan
