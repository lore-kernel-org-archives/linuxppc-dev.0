Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C423767CC1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 12:14:57 +1100 (EST)
Date: Wed, 15 Nov 2006 17:14:54 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH v2 -- fixed changelog] [POWERPC] Add support for Rev. B of
	PowerPC 440SPe
Message-ID: <20061116011453.GA19241@gate.ebshome.net>
References: <adalkmf44eu.fsf@cisco.com> <adaac2v2d2g.fsf@cisco.com>
	<20061114090102.GA16520@gate.ebshome.net>
	<adapsbowdgg.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adapsbowdgg.fsf@cisco.com>
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

On Wed, Nov 15, 2006 at 02:29:51PM -0800, Roland Dreier wrote:

[snip]

> I think there have to be switches (or equivalently, look-up tables)
> since there's no regularity in where the DCRs/SDRs for the different
> PCIe ports are.

Uhh, I was afraid you were gonna say this. HW guys don't make our life 
easier :).

I think look-up tables are fine. It's not a fast path, is it?

-- 
Eugene
