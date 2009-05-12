Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12594DDF62
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 12:48:53 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: prasad@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org
Subject: Re: [RFC] Hardware Breakpoint interfaces implementation for PPC64 
In-reply-to: <4234.1242089764@neuling.org> 
References: <20090511200355.GA17988@in.ibm.com> <4234.1242089764@neuling.org>
Date: Tue, 12 May 2009 12:48:52 +1000
Message-ID: <19702.1242096532@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +struct arch_hw_breakpoint {
> > +	char		*name; /* Contains name of the symbol to set bkpt */
> > +	unsigned long	address;
> > +	u8		type;
> > +};
> 
> Can you reorder this to pack the struct better (ie. put the unsigned
> long first).

Oops, this is a char * not just a char.  Order is fine.

Mikey
