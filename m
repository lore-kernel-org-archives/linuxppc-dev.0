Return-Path: <ryan@elevated-networks.com>
Received: from baracus.dreamhost.com (baracus.dreamhost.com [66.33.205.11])
	by ozlabs.org (Postfix) with ESMTP id 7CA146857D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 05:23:05 +1000 (EST)
In-Reply-To: <20051028155510.17662.qmail@web33413.mail.mud.yahoo.com>
References: <20051028155510.17662.qmail@web33413.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5E59D740-D361-4531-8A33-8C0FE5282B77@elevated-networks.com>
From: Ryan Wilkins <ryan@elevated-networks.com>
Date: Fri, 28 Oct 2005 14:51:33 -0400
To: Jeff Stevens <jsteve17@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Howto Cross Compile GCC to run on PPC Platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've used crosstool-0.38 to generate an ARMv5b cross compiler and  
then the script referenced from the link below to create the native  
GCC from the cross compiler.  It should really be not much different  
to make a PPC native platform.  I hope you have a fast machine.. It  
takes a while.

http://sources.redhat.com/ml/crossgcc/2005-08/msg00037.html

Ryan Wilkins

On Oct 28, 2005, at 11:55 AM, Jeff Stevens wrote:

>    I am trying to compile GCC on an x86 platform to
> run natively on an embedded PPC platform.  I am able
> to compile gcc as a cross compiler (to run on x86),
> but can't seem to get it to cross compile gcc (to run
> on ppc).  Does anyone know of a good HowTo to do this?
>  I'm currently downloading the source distro of ELDK,
> so if it's already in there I'll find it, but if there
> is one elsewhere online please let me know.
