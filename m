Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5C8ADDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 01:24:54 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: for-2.6.25 branch created in powerpc.git 
In-Reply-To: Your message of "Mon, 03 Dec 2007 15:45:50 +1100."
	<18259.35326.516899.603549@cargo.ozlabs.ibm.com>
References: <18259.35326.516899.603549@cargo.ozlabs.ibm.com> 
Date: Mon, 03 Dec 2007 08:24:46 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IzCE2-0007NO-4F@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Paul Mackerras mumbled:
> I have created a for-2.6.25 branch in my powerpc.git repository and
> added the patches listed below to it.  The master branch points to the
> same place as the for-2.6.25 branch.
> 
> Paul.
> 
> Benjamin Herrenschmidt (2):
> Johannes Berg (3):
> Linas Vepstas (3):
> Nathan Lynch (1):
> Stephen Rothwell (5):
> joe@perches.com (2):

Paul,

Could you please add these two:

    http://patchwork.ozlabs.org/linuxppc/patch?id=14713
    http://patchwork.ozlabs.org/linuxppc/patch?id=14714

and possibly this Cell variant:

    http://patchwork.ozlabs.org/linuxppc/patch?id=14712

if Arnd doesn't get to it.   Kumar has picked up the 8xxx
variant already, and Josh has grabbed 4xx version has already
been applied.

Please let me know if rebasing is needed.

Thanks,
jdl
