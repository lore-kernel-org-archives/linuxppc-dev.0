Return-Path: <jdl@jdl.com>
Received: from jdl.com (mail.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8CB2367A6B
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 23:27:50 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: please pull powerpc.git 'merge' branch 
In-Reply-To: Your message of "Wed, 21 Jun 2006 08:08:28 CDT."
	<86FC5258-6CA0-4AED-B346-3788DBE5E9F8@kernel.crashing.org>
References: <17561.418.97341.74610@cargo.ozlabs.ibm.com>
	<3F041A9D-F1D9-4FF9-977F-E09D924D0741@kernel.crashing.org>
	<E1Ft2NP-0001ao-30@jdl.com>
	<86FC5258-6CA0-4AED-B346-3788DBE5E9F8@kernel.crashing.org>
Date: Wed, 21 Jun 2006 08:27:46 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ft2kE-0001c4-Rt@jdl.com>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> 
> I know you'll fix the issues. Its just that the usual model is to fix  
> the issues before pushing upstream.
>
> Also, havent seen any comments on my last sent of responses on the  
> patches :)

Well, where your comments are in conflict with Ben's, we'll let
you two duke it out. :-)

Where things need to be fixed, we'll fix it.  (They really
were minor things for the most part.)

In the one case where you suggested removing an #include,
we can't; it is needed.

In the meantime, remember this is a _new_ board port.  It's not
going to cause anyone undue stress with some form of breakage
on the new board!

Thanks,
jdl
