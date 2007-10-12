Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3CD83DE047
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 15:38:28 +1000 (EST)
Date: Thu, 11 Oct 2007 22:38:18 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git master branch
In-Reply-To: <18190.63495.790381.701352@cargo.ozlabs.ibm.com>
Message-ID: <alpine.LFD.0.999.0710112233590.6887@woody.linux-foundation.org>
References: <18190.63495.790381.701352@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Fri, 12 Oct 2007, Paul Mackerras wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git master

I got a merge conflict on Documentation/powerpc/booting-without-of.txt, 
which I tried to fix up. I may or may not have succeeded. 

The issue was the interaction of David Gibson's device-tree-aware EMAC 
driver which got merged with the net driver update through the networking 
tree, and all the other new cases added in the PPC tree.

I think I merged it ok, but you guys should check and send me any fixes.

		Linus
