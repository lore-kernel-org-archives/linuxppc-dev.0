Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D6DC0DDEB6
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 09:54:22 +1100 (EST)
Message-ID: <47ACDD22.2050600@am.sony.com>
Date: Fri, 08 Feb 2008 14:52:18 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 0/6] PS3 fixups for 2.6.25
Content-Type: text/plain; charset=UTF-8
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

Here are a few PS3 fixups to apply for 2.6.25.

  [patch 1/6] PS3: Fix lpm set bookmark
  [patch 2/6] PS3: Fix lpm read pm interval
  [patch 3/6] PS3: Fix bootwrapper hang bug
  [patch 4/6] PS3: Use system reboot on restart
  [patch 5/6] PS3: Sys-manager code cleanup
  [patch 6/6] PS3: Update sys-manager button events

-Geoff




-- 
