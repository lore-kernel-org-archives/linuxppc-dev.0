Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62A55DDF7D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 04:19:19 +1100 (EST)
Date: Tue, 25 Mar 2008 10:19:07 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20080325171907.GA24854@farnsworth.org>
MIME-Version: 1.0
Subject: kexec-tools patches for 32-bit arch/powerpc kernels
Content-Type: text/plain; charset=us-ascii
Cc: Matt Wagantall <mwagantall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A while back, I posted some kernel patches adding kexec support for
32-bit platforms in arch/powerpc.  We had hoped to clean up the
corresponding kexec-tools patches, but that hasn't happened yet.
Someone (hi Matt) recently asked about those kexec-tools patches,
so I've made them available via anon ftp.  Please note that this
is a work in progress.  The code for 32- and 64-bit arch/powerpc
support needs to be merged together.  Nevertheless, it may prove
useful even in its current state.

The patches are available at:

ftp://source.mvista.com/pub/dfarnsworth/kexec-tools-32-bit-arch-powerpc-patches.tgz

-Dale
