Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4875C1007FA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 15:37:03 +1100 (EST)
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <CC1D5EB1-27C2-47A1-96D8-D007D86C4881@kernel.crashing.org>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
	<4B0C1A25.8030401@yahoo.es>
	<CC1D5EB1-27C2-47A1-96D8-D007D86C4881@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 15:36:56 +1100
Message-ID: <1259210216.16367.249.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-24 at 22:00 +0100, Segher Boessenkool wrote:
> 
> Sure, the memory controllers don't do coherency.  I'm slightly worried
> about two things:
> 1) Will the generic code use M=0 as well?  Is it a problem if it  
> doesn't?

We can make it not do it.

> 2) Do lwarx. etc. work in M=0? 

They should hopefully... as long as you don't rely on the reservation
blowing as a result of a DMA write.

Cheers,
Ben
