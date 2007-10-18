Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0BEBADDF00
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 03:50:13 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Merge dtc
Date: Thu, 18 Oct 2007 12:49:54 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue Oct 16 15:02:17 EST 2007, David Gibson wrote:

> This very large patch incorporates a copy of dtc into the kernel
> source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> longer an external dependency to build kernels with configurations
> which need a dtb file.
>
> Signed-off-by: David Gibson <david at gibson.dropbear.id.au>
>
> Too big for the list, full patch at
> http://ozlabs.org/~dgibson/home/merge-dtc.patch+

So split it up.   The obvious one is "here is the unique content, then 
copy these files from dtc git" would have been better.

I finally went and looked at the url.  The Kbuild integration is wrong. 
  It should build dtc in dtc-src and run the binary from there, and the 
rules should be in a Kconfig as a normal host-target in that directory. 
   (I don't have a problem with that Kbuild including Makefie.dtc).

things like the dependancy on scripts_basic in the top level Makefile.

milton
