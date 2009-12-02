Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id BE0641007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 11:22:59 +1100 (EST)
Received: from landley.net (localhost [127.0.0.1])
	by grelber.thyrsus.com (Postfix) with ESMTP id E45959F0429
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 19:24:40 -0500 (EST)
From: Rob Landley <rob@landley.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Serial console under current qemu is still an issue.
Date: Tue, 1 Dec 2009 18:13:23 -0600
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200912011813.23771.rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Last month I reported a serial console problem:
  http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-October/076727.html

And bisected the problem to find the patch to revert that fixed it for me:
  http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-October/077059.html

The bug still hasn't been fixed, but reverting the patch stopped working during 
this developmpent series (because it no longer cleanly reverse applies).

Would anybody like to comment on this?  I can provide a qemu-based test 
environment if you'd like, it's easily reproducible...

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
