Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 93BF367A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 05:51:33 +1000 (EST)
Date: Thu, 1 Jun 2006 12:51:29 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Chris Dumoulin <cdumoulin@ics-ltd.com>
Subject: Re: Pinned TLB entries with 2.6 linux kernel on PPC4xx
Message-ID: <20060601195129.GA15262@gate.ebshome.net>
References: <447F4021.5030109@ics-ltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <447F4021.5030109@ics-ltd.com>
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

On Thu, Jun 01, 2006 at 03:29:37PM -0400, Chris Dumoulin wrote:
> Does the idea of creating pinned TLB entries (ones that will never be 
> overwritten) make sense for a PPC4xx (specifically PPC405) 2.6 linux 
> kernel? If so, how would this be accomplished?

44x kernel already pins some TLB entries, 40x may use this approach to 
increase performance (I use this in my internal 2.4 tree 
quite successfully).

Old 2.4 trees (linuxppc-2.4 or devel_2_4) have TLB pinning support 
for 40x, you can look at the implementation there.

-- 
Eugene
