Return-Path: <bgat@billgatliff.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id E1819B7C33
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Apr 2010 13:42:49 +1000 (EST)
Received: by gyf2 with SMTP id 2so3050799gyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Apr 2010 20:42:47 -0700 (PDT)
Message-ID: <4BC3E888.2050006@billgatliff.com>
Date: Mon, 12 Apr 2010 22:44:08 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: kernel BUG at kernel/timer.c:643!
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Is anyone seeing this message on an MPC5200 platform with the current
HEAD from Linus Torvalds' git repo?  I just did a rebase, and started
seeing it...


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
