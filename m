Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB7D6B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 21:00:16 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4JAv8cQ010271
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2011 04:57:08 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4JAxxHC328954
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2011 04:59:59 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4JB56xB029204
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2011 05:05:06 -0600
Date: Thu, 19 May 2011 07:01:05 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Eric Van Hensbergen <ericvh@gmail.com>
Subject: Re: [PATCH 1/7] [RFC] Mainline BG/P platform support
Message-ID: <20110519110105.GB25179@zod.rchland.ibm.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 18, 2011 at 04:24:49PM -0500, Eric Van Hensbergen wrote:
>The Linux kernel patches for the IBM BlueGene/P have been open-sourced
>for quite some time, but haven't been integrated into the mainline Linux
>kernel source tree.  This is the first patch series of several where I
>will attempt to cleanup and mainline the already public patches.  I
>welcome feedback as well as any help I can get.  I'm drawing on
>the patches available for the IBM Compute Node kernel, the ZeptoOS project
>and the Kittyhawk project.
>(all available from http://wiki.bg.anl-external.org)
>
>I'll be prioritizing core patches which are harder to keep current with
>mainline due to merge conflicts and then slowly incorporating the drivers
>and other extensions (if acceptable after community review).
>
>I'll be maintaining the patchset in my kernel.org repository
>(/pub/scm/linux/kernel/git/ericvh/bluegene.git) under the bluegene
>branch with the source repos (zepto, kittyhawk, ibmcn) available in
>respective branches.  Ben - if you would prefer me to send pull requests
>once we get rolling, I can switch to that -- otherwise I'll stick to
>just submitting patches to the list assuming you'll pull them when they
>become acceptable.  Thanks for your attention reviewing these patches.

This is going to get slightly messy if there are lots of changes in
platforms/44x and/or head_44x.S.  Most 4xx changes go through my tree,
and I'm happy to pull from your tree once things get off the ground.  We
just need to make sure and coordinate as we go.

My tree is fairly low-churn (as is all of 4xx) so hopefully I'm worried
for nothing.

>Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
>---
> MAINTAINERS |    8 ++++++++
> 1 files changed, 8 insertions(+), 0 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 69f19f1..3ffca88 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -3863,6 +3863,14 @@ S:	Maintained
> F:	arch/powerpc/platforms/40x/
> F:	arch/powerpc/platforms/44x/
>
>+LINUX FOR POWERPC BLUEGENE/P
>+M:	Eric Van Hensbergen <ericvh@gmail.com>
>+W:	http://bg-linux.anl-external.org/wiki/index.php/Main_Page
>+L:	bg-linux@lists.anl-external.org
>+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/bluegene.git
>+S:	Maintained
>+F:	arch/powerpc/platforms/44x/bgp*

This should probably be the last patch in the series.  You have a file
pattern listed for files that don't exist at all in any of the other
patches you submitted :).

josh
