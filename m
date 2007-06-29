Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 8BA86DDEAB
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 05:48:53 +1000 (EST)
Date: Fri, 29 Jun 2007 21:48:52 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: for-2.6.23 branch in powerpc.git created
In-Reply-To: <18051.22185.374607.755419@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.60.0706292131390.4227@poirot.grange>
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0706151915580.5979@poirot.grange>
	<18051.22185.374607.755419@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Jun 2007, Paul Mackerras wrote:

> Guennadi Liakhovetski writes:
> 
> > These two i2c patches:
> > 
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037327.html
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037328.html
> > 
> > also would be nice to get in, although, they only make sense with an ack 
> > from Scott Wood and another patch from him, as explained in links above...
> 
> Looks OK, but the first of those two patches doesn't have a
> Signed-off-by: line, and the description is not suitable.
> 
> Please repost that patch with a nice description that describes what
> the patch does and why, without references to other web pages.  You
> don't need to describe what is different from previous patches or who
> suggested those changes.

Ok, just reposted. I even used the original subject line and the 
description from Scott's email. I also removed the part for 
drivers/i2c/busses/i2c-mpc.c - it is a separate patch 
http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036079.html and I hope 
it'll make it in either via ppc or via i2c tree (it was cc'ed) as well as 
http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036333.html (sorry, 
Paul, for links again).

Speaking about i2c@lm-sensors.org - which way should these patches go? Is 
it the usual separation drivers/i2c goes via i2c and arch/powerpc via ppc? 
Or should I also email i2c folks to tell them not to use the original 
patch from Scott?

Thanks
Guennadi
---
Guennadi Liakhovetski
