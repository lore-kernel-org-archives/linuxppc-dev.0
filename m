Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCCFDDDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 23:08:31 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] Kernel: Move all technical descriptons of the Device
	Tree Complier
In-Reply-To: Your message of "Thu, 12 Jul 2007 13:42:22 +1000."
	<18069.41758.420516.135000@cargo.ozlabs.ibm.com>
References: <1184190359.25384.129.camel@ld0161-tx32>
	<18069.41758.420516.135000@cargo.ozlabs.ibm.com>
Date: Thu, 12 Jul 2007 08:08:25 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1I8yPB-0003Uw-Rt@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Paul Mackerras mumbled:
> Jon Loeliger writes:
> 
> > and its formats, command lines, descriptions, etc,
> > over to the Device Tree Compiler repositories now.
> 
> Hrm, section II (DT block format) is a description of a kernel
> interface, and I think it should stay.  After all, there's nothing

Hmm.  That's a good point; I'll buy it.  All of section II, then?

> I have no problem with that section being copied over to the dtc
> source.
> 
> I also don't mind section IV being removed, although a sentence saying
> that dtc is useful for generating dtbs, and where to find dtc, would
> be useful.

I will respin the patch as suggested!

jdl
