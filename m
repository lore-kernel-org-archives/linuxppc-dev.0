Return-Path: <amodra@bigpond.net.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E6D66B708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 14:40:11 +1000 (EST)
Received: from nskntmtas02p.mx.bigpond.com (nskntmtas02p.mx.bigpond.com
	[61.9.168.140]) by ozlabs.org (Postfix) with ESMTP id D1254DDDE5
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 14:40:11 +1000 (EST)
Date: Thu, 9 Jul 2009 14:10:07 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: binutils 2.19 issue with kernel link
Message-ID: <20090709044007.GB3181@bubble.grove.modra.org>
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
	<E6EB8DA7-8B38-4C97-BE3C-4649DFA295C8@kernel.crashing.org>
	<AB02ECF3-9C72-436B-A946-CBCCD3859762@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AB02ECF3-9C72-436B-A946-CBCCD3859762@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	bug-binutils@gnu.org, Edmar Wienskoski-RA8797 <Edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 08, 2009 at 10:52:59PM -0500, Kumar Gala wrote:
> To further verify this if I switch the -me500 to -mspe and build things 
> seem to be ok.  This further points at some APU section related bug.

Like omitting .PPC.EMB.apuinfo from your kernel link script?  See the
ld info doc on orphan sections.

-- 
Alan Modra
Australia Development Lab, IBM
