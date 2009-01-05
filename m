Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 23925DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 04:40:52 +1100 (EST)
Date: Mon, 5 Jan 2009 20:40:50 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v4 0/2] MPC83xx PCI-E support
Message-ID: <20090105174050.GA30219@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Huang Changming <Chang-Ming.Huang@freescale.com>,
	Liu Dave <DaveLiu@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Thanks for the comments on the previous versions, and here is the
updated patch set to support PCI-E on MPC83xx boards.

Changes since v3:
- TAL register programming changed per new reference manual for 83xx
  processors;
- dts files no longer specify config window in regs = <>. Instead, PCI-E
  code reads cfg window BAR to determine config space area;
- dts files no longer disable pcie nodes, now Linux detects unconfigured
  PCI-E controllers at run-time.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
