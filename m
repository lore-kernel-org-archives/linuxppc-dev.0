Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 76758679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 04:16:44 +1000 (EST)
Date: Fri, 6 May 2005 11:16:42 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050506181642.GE19401@gate.ebshome.net>
References: <427B22A0.8010704@ru.mvista.com>
	<20050506081805.GA19401@gate.ebshome.net>
	<427B3465.1070502@ru.mvista.com>
	<20050506170809.GC19401@gate.ebshome.net>
	<7ad6626ea88c1e1ec98d310f4db438f7@embeddededge.com>
	<20050506173246.GD19401@gate.ebshome.net>
	<1ee36950a2147d4208cf9af575be7478@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1ee36950a2147d4208cf9af575be7478@embeddededge.com>
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

On Fri, May 06, 2005 at 01:45:58PM -0400, Dan Malek wrote:
> 
> On May 6, 2005, at 1:32 PM, Eugene Surovegin wrote:
> 
> >Yeah, I think 3 parameters approach is OK. IOCTL handlers are made
> >like this and so far they proved to be quite flexible.
> 
> I thought we also discussed placing the PHY irq numbers in the
> platform data structure at one time? :-)  

This is exactly what Vitaly is doing in his patches. My comment was 
about general use of 3 parameters "feature" calls vs variadic ones, 
not about you particular example for PHY IRQ :).

-- 
Eugene
