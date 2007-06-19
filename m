Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 82BF7DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 05:02:56 +1000 (EST)
Date: Tue, 19 Jun 2007 21:02:53 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: 2.6.22: ERROR: "__ucmpdi2" [drivers/net/s2io.ko] undefined!
Message-ID: <20070619190253.GA19419@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


What happend to __ucmpdi2 from David Woodhouse?
google has a few hits about stuff like this on 32bit powerpc with gcc 4.1.2:

ERROR: "__ucmpdi2" [drivers/net/s2io.ko] undefined!

using the drivers/net/s2io* files from 2.6.21 with 2.6.22-rc5 fixes the
compile.

25805dcf9d83098cf5492117ad2669cd14cc9b24 adds two u64 >>= 48 followed by
a switch statement (line 2889 and 6816).
