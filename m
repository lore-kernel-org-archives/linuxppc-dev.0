Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D068467B54
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 10:35:59 +1000 (EST)
Date: Tue, 8 Aug 2006 19:35:55 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Perhaps git-update-server-info needs to be run on
	.../paulus/powerpc.git?
Message-Id: <20060808193555.301bc229.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus' tree clones fine, paulus' doesn't:

$ git clone http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?
$ git --version
git version 1.4.1
$ cg-clone http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
defaulting to local storage area
Fetching head...
Fetching objects...
Getting alternates list for http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
Also look at http://git.kernel.or
Getting pack list for http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
Getting pack list for http://git.kernel.or
error: Unable to find b1f5b9df2ae1f4eede001d7751b099d4ae34be95 under http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
Cannot obtain needed blob b1f5b9df2ae1f4eede001d7751b099d4ae34be95
while processing commit 81b73dd92b97423b8f5324a59044da478c04f4c4.
progress: 12 objects, 8836 bytes
cg-fetch: objects fetch failed
$

Kim
