Return-Path: <geoff@white.local.net>
Received: from outbound10-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 94D6CDDE34
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 13:58:39 +1000 (EST)
Message-Id: <20070808033119.833895506@am.sony.com>
Date: Tue, 07 Aug 2007 20:31:19 -0700
From: geoffrey.levand@am.sony.com
To: paulus@samba.org
Subject: [patch 0/3] PS3 bugfix patches for 2.6.23
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

This small set of PS3 bugfix patches for 2.6.23.

  [patch 1/3] PS3: Fix storage probe logic
  [patch 2/3] PS3: Remove incomplete message
  [patch 3/3] PS3: Update ps3_defconfig

Patch 1 fixes a cold startup timing bug in the hard disk probe logic.

Patch 2 removes the 'incomplete' message in the PS3 Kconfig.  We now
have all drivers and platform support needed to build a kernel for the
PS3.  The only major thing missing is wireless networking support, which
we plan to have ready for 2.6.24.

-Geoff

-- 
