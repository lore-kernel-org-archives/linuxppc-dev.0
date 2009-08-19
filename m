Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 94D56B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 08:17:46 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0F6CDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 08:17:45 +1000 (EST)
Subject: Re: [PATCH/RFC] powerpc/mm: Cleanup handling of execute permission
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <16251558-DDF6-46C3-98C2-2FC7CD8A398B@kernel.crashing.org>
References: <1248766373.30993.50.camel@pasglop>
	<FBB5798A-EE85-4B18-8883-F6182B203996@kernel.crashing.org>
	<20090818205621.GB2530@zod.rchland.ibm.com>
	<1250634800.4810.1.camel@pasglop>
	<16251558-DDF6-46C3-98C2-2FC7CD8A398B@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 20 Aug 2009 08:17:36 +1000
Message-Id: <1250720256.4810.36.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-19 at 15:59 -0500, Becky Bruce wrote:
> On Aug 18, 2009, at 5:33 PM, Benjamin Herrenschmidt wrote:
> 
> > 
> FYI, I pulled your updated test branch this morning, booted, and did a  
> full LTP run on 8572.  The results are consistent with the baseline I  
> have, so it looks like the issue is properly fixed.

Thanks !

Cheers,
Ben.
