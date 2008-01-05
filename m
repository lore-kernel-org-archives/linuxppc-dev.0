Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C74CEDDE0F
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 14:13:36 +1100 (EST)
Message-ID: <477EF59C.2070809@am.sony.com>
Date: Fri, 04 Jan 2008 19:12:28 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 0/3] PS3 logical performance monitor patches for 2.6.25
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

This is a small set of patches that adds support for the PS3's logical
performance monitor.

The logical performance monitor is a hypervisor abstraction that provides
access to the Cell processor's performance monitoring features needed by
profilers such as oprofile and perfmon.

Please apply for 2.6.25.

  [1/3] PS3: Add logical performance monitor repository routines
  [2/3] PS3: Add logical performance monitor device support
  [3/3] PS3: Add logical performance monitor driver support

-Geoff


-- 
