Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C3450B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 01:25:13 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D893DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 01:25:12 +1000 (EST)
Message-Id: <4B3B917C-C8B0-416B-888D-13E6C0645BF8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Alan Modra <amodra@bigpond.net.au>
In-Reply-To: <20090709044007.GB3181@bubble.grove.modra.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: binutils 2.19 issue with kernel link
Date: Thu, 9 Jul 2009 10:22:29 -0500
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
	<E6EB8DA7-8B38-4C97-BE3C-4649DFA295C8@kernel.crashing.org>
	<AB02ECF3-9C72-436B-A946-CBCCD3859762@kernel.crashing.org>
	<20090709044007.GB3181@bubble.grove.modra.org>
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


On Jul 8, 2009, at 11:40 PM, Alan Modra wrote:

> On Wed, Jul 08, 2009 at 10:52:59PM -0500, Kumar Gala wrote:
>> To further verify this if I switch the -me500 to -mspe and build  
>> things
>> seem to be ok.  This further points at some APU section related bug.
>
> Like omitting .PPC.EMB.apuinfo from your kernel link script?  See the
> ld info doc on orphan sections.

Ok, not terribly enlightening, but why would .PPC.EMB.apuinfo sections  
be different than something like .debug sections which we also dont  
list in the linker script.

- k
