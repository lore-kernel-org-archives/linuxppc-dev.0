Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 34BC767CBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 12:26:34 +1100 (EST)
Date: Wed, 15 Nov 2006 17:26:31 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH v2 -- fixed changelog] [POWERPC] Add support for Rev. B of
	PowerPC 440SPe
Message-ID: <20061116012631.GA27724@gate.ebshome.net>
References: <adalkmf44eu.fsf@cisco.com> <adaac2v2d2g.fsf@cisco.com>
	<20061114090102.GA16520@gate.ebshome.net>
	<adapsbowdgg.fsf@cisco.com>
	<20061116011453.GA19241@gate.ebshome.net>
	<ada3b8kuqzn.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ada3b8kuqzn.fsf@cisco.com>
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

On Wed, Nov 15, 2006 at 05:20:28PM -0800, Roland Dreier wrote:
>  > I think look-up tables are fine. It's not a fast path, is it?
> 
> Nope, that would be fine.  I'll definitely cut down on the code
> duplication -- I'm just not sure what will end up being cleanest.  I
> don't see that much difference between a switch and a look-up table
> for finding the base DCR index for a particular port.

OK, I was just wanted to make sure you were aware that mfdcr/mtdcr 
supported run-time specified DCR number (from that code it wasn't 
clear).

-- 
Eugene
