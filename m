Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72453DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 12:49:52 +1100 (EST)
Date: Wed, 26 Mar 2008 20:47:09 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: PPC upstream kernel ignored DABR bug
Message-ID: <20080326204709.614138ba@zod.rchland.ibm.com>
In-Reply-To: <20080326155732.6b01240f@zod.rchland.ibm.com>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
	<200803122330.36905.jens@de.ibm.com>
	<20080313014745.DE97826F992@magilla.localdomain>
	<20080326155732.6b01240f@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Jan@ozlabs.org,
	Kratochvil <jan.kratochvil@redhat.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 26 Mar 2008 15:57:32 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Wed, 12 Mar 2008 18:47:45 -0700 (PDT)
> Roland McGrath <roland@redhat.com> wrote:
> 
> > The only machine I have at home for testing powerpc is an Apple G5,
> > supplied to me by IBM.  It says:
> > 	cpu             : PPC970FX, altivec supported
> > 	revision        : 3.0 (pvr 003c 0300)
> > so I am guessing this document applies to the chips I have.  Since I can't
> > test on other chips myself, it is plausible from what I've seen that there
> > is no mysterious kernel problem and only this hardware problem.  The
> > description of the hardware problem would not make me think that it would
> > behave this way, but it is not very detailed or precise, or at least does
> > not seem so to a reader not expert on powerpc.
> 
> I ran the testcase on my older G5 today with:
> 
> cpu             : PPC970, altivec supported
> revision        : 2.2 (pvr 0039 0202)
> 
> and it also failed after a few iterations.  This was with
> 2.6.25-0.121.rc5.git4.fc9 as the kernel, which is fairly close to mainline.  At the least, this doesn't seem to be 970FX related.  I'll try building a vanilla 2.6.25-rc7 later this evening to see if that makes a difference.

Still failed with a -vanilla build of 2.6.25-rc7.

josh
