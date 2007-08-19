Return-Path: <jonli447@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id E5F45DDE0C
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 04:11:47 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so633405nfd
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2007 11:11:45 -0700 (PDT)
Message-ID: <9050bda20708191111n497e1565h87eb9a2423a6ba56@mail.gmail.com>
Date: Sun, 19 Aug 2007 13:11:45 -0500
From: "Jonathan Li" <jonli447@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: LINKSTATION default config update for linux-2.6.23-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: g.liakhovetski@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Please update the default config in linux-2.6.23 for the LINKSTATION
board with the following changes:

SK98LIN SysKonnect driver is deprecated.  Use SKGE instead.

Regards,

Jon
