Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	by ozlabs.org (Postfix) with ESMTP id 5FB06DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 12:39:33 +1000 (EST)
To: "Siva Prasad" <sprasad@bivio.net>
Subject: Re: mpc86xx - couple of questions... 
In-reply-to: <D83235F0F3C86D4D889D8B9A0DA8C6D702315472@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D702315472@corpexc01.corp.networkrobots.com>
Date: Tue, 13 May 2008 20:56:24 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Jw6EC-0005sE-3W@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hi,
> 
> I took the latest tree from linux/kernel/git/galak/powerpc.git
> (2.6.26-rc2), and the latest dtc from linux/kernel/git/galak/dtc.git.

Hmm.  galak, good.  Or paulus.  But the latest DTC is
found on jdl.com still.

> After compiling, I am having couple of questions.
> 
> 1) Doesn't the latest dtc support /memreserve/ on the top before or
> after /dts-v1/?

/dts-v1/ is first as it sets the framework for the
rest of the source file.

> This used to work fine for previous compiler and this is
> giving an error now.

Can you show us the source and the compiler output?

jdl
