Return-Path: <hollisb@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 240FADDDEF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 04:21:24 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9VHL1lU028882
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 11:21:01 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9VHLEBc058926
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 11:21:16 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9VHL1Qg019425
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 11:21:01 -0600
Subject: Re: [RFC] a little disassembly infrastructure
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18690.35483.845880.696901@cargo.ozlabs.ibm.com>
References: <1224867546.9634.42.camel@localhost.localdomain>
	<18690.35483.845880.696901@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 31 Oct 2008 12:20:56 -0500
Message-Id: <1225473656.14521.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-10-25 at 13:55 +1100, Paul Mackerras wrote:
> Hollis Blanchard writes:
> 
> > I've also found xmon's ppc-opc.c. That parses the opcode and operands,
> > so could use some shared macros.
> 
> That's a direct copy from GNU binutils.  I'm reluctant to modify it
> because then maintenance becomes more than just copying in the latest
> version.

OK, makes sense.

Can I get an Acked-by on this patch, or should I move the code to a
KVM-specific header? Either way I'll submit it via the KVM tree as
usual.

-- 
Hollis Blanchard
IBM Linux Technology Center
