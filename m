Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw3.br.ibm.com (igw3.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw3.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F276DE1EE
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 04:13:37 +1000 (EST)
Received: from mailhub1.br.ibm.com (unknown [9.18.232.109])
	by igw3.br.ibm.com (Postfix) with ESMTP id EA37B3900BB
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 14:58:20 -0300 (BRST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4NIDYGR536802
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 15:13:34 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4NIDKd9017863
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 15:13:20 -0300
Subject: Re: [RFC] 4xx hardware watchpoint support
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20080522064613.088AB26FA24@magilla.localdomain>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<20080522064613.088AB26FA24@magilla.localdomain>
Content-Type: text/plain
Date: Fri, 23 May 2008 15:12:27 -0300
Message-Id: <1211566348.15367.15.camel@gargoyle>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 23:46 -0700, Roland McGrath wrote:
> > I would think there would be a different REQUEST value to mean "set a
> > hardware breakpoint".  Roland McGrath (cc'd) might be able to tell us
> > what other architectures do.
> 
> Other architectures don't give a good model to follow.  (If anything,
> they just trivally virtualize their own idiosyncratic hardware.)
> 
> What I want to see done for this in the future is reviving and
> finishing the hw_breakpoint work begun by Alan Stern, and porting
> that to each arch's particular hardware features.  On that we'd
> build any new interfaces in abstract machine-independent terms,
> just describing the constraints of what the hardware can do,
> rather than having the user interface involve mimicking hardware
> encodings.  (The existing hardware-idiosyncratic ptrace interfaces
> would tie into hw_breakpoint for backward compatibility.)
> 
> 

Kumar was just mentioning this post a few messages ago:
http://ozlabs.org/pipermail/linuxppc-dev/2008-May/055745.html

That is a very interesting approach to handle all the differences
between each processor's architecture, and a much cleaner way to set the
facilities we want than the current interface we have. Do you know what
is the status of this work? Did it move any further?

Best Regards,
Luis
