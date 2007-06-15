Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DA4F3DDFAD
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 03:47:10 +1000 (EST)
Date: Fri, 15 Jun 2007 19:47:07 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: for-2.6.23 branch in powerpc.git created
In-Reply-To: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.60.0706151915580.5979@poirot.grange>
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
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

On Fri, 15 Jun 2007, Paul Mackerras wrote:

> I have created a for-2.6.23 branch in the powerpc.git repository
> (git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git)
> where I have started queueing up patches to go in once the 2.6.23
> merge window opens.  For now at least it's the same as the master
> branch.
> 
> The patches I put in are listed below.  If you have a patch that
> should go in but isn't listed, remind me about it.

How about this one:

http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036319.html

Don't think linking timer.o if CONFIG_RTC_CLASS is defined presents a 
problem now, but it will later, when platforms appear, that wish to use PM 
and use generic rtc.

These two i2c patches:

http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037327.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037328.html

also would be nice to get in, although, they only make sense with an ack 
from Scott Wood and another patch from him, as explained in links above...

Thanks
Guennadi
---
Guennadi Liakhovetski
