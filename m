Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DF111B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Jan 2011 18:26:41 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] pata_mpc52xx: inherit from
	ata_bmdma_port_ops
References: <201101031445.47922.roman.fietze@telemotive.de>
	<4D21FA4D.3030506@mvista.com>
	<20110109224820.GB26607@mtj.dyndns.org>
In-Reply-To: <20110109224820.GB26607@mtj.dyndns.org>
MIME-Version: 1.0
Message-ID: <201101100826.34728.roman.fietze@telemotive.de>
Date: Mon, 10 Jan 2011 08:26:34 +0100
Content-Type: Text/Plain;
  charset="us-ascii"
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	linuxppc-dev@lists.ozlabs.org, Sergei Shtylyov <sshtylyov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Tejun,

On Sunday, 09.January.2011 23:48:20 Tejun Heo wrote:

> Fix it.

I can confirm that, it's fixed.

Thank's a lot. Should have looked into it, that was really a simple
fix.


Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
