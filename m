Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 30B6167AC7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 03:32:49 +1000 (EST)
Date: Fri, 6 May 2005 10:32:46 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050506173246.GD19401@gate.ebshome.net>
References: <427B22A0.8010704@ru.mvista.com>
	<20050506081805.GA19401@gate.ebshome.net>
	<427B3465.1070502@ru.mvista.com>
	<20050506170809.GC19401@gate.ebshome.net>
	<7ad6626ea88c1e1ec98d310f4db438f7@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7ad6626ea88c1e1ec98d310f4db438f7@embeddededge.com>
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

On Fri, May 06, 2005 at 01:23:21PM -0400, Dan Malek wrote:
> 
> On May 6, 2005, at 1:08 PM, Eugene Surovegin wrote:
> 
> >Yeah, it's better, I'm only wondering what if some board has separate
> >PHY interrupt lines for each FCC? Define name - "PHY_INTERRUPT" was
> >chosen quite badly IMHO :).
> 
> One of my feature_calls is:
> 	embed_feature_call(CPM_FTR_FCC1, REQ_FTR_PHY_INT, &irq)
> 
> and so on for every Ethernet port.  This presents my current coding
> challenge, do I want this to be a varargs function or we just always 
> have
> three parameters, where the last one is ignored if not necessary, a
> pointer for an out value, or a pointer to a data structure for more
> complex information.  Right now I have it coded as always three
> parameters.

Yeah, I think 3 parameters approach is OK. IOCTL handlers are made 
like this and so far they proved to be quite flexible.

-- 
Eugene
