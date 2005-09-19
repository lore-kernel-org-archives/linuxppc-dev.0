Return-Path: <jdl@jdl.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: Your message of "Mon, 19 Sep 2005 09:22:25 +1000."
	<17197.63153.78371.490616@cargo.ozlabs.ibm.com>
References: <1126631205.11056.15.camel@cashmere.sps.mot.com>
	<17197.63153.78371.490616@cargo.ozlabs.ibm.com>
Date: Sun, 18 Sep 2005 21:20:04 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1EHBGG-0006RR-Ao@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: Merge Question on asm-ppc*/rwsem.h 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So sprach Paul Mackerras:
> 
> I think the difference is that the atomic ops that return a value also
> have include a barrier on ppc64, but don't on ppc32 (although they
> probably should).  IOW I think the merged case should follow ppc64
> here.

Excellent!

I will submit that patch in the style of ppc64 early this week.

Thanks for the feedback,
jdl
