Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0F969B710A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 01:34:19 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Tejun Heo <tj@kernel.org>
Subject: Re: PowerPC MPC5200B ATA MWDMA regression
References: <201101031445.47922.roman.fietze@telemotive.de>
	<20110103135929.GO18831@htj.dyndns.org>
In-Reply-To: <20110103135929.GO18831@htj.dyndns.org>
MIME-Version: 1.0
Message-ID: <201101031534.13533.roman.fietze@telemotive.de>
Date: Mon, 3 Jan 2011 15:34:13 +0100
Content-Type: Text/Plain;
  charset="us-ascii"
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hallo Tejun,

On Monday, 03.January.2011 14:59:29 Tejun Heo wrote:

> Which driver is it?

drivers/ata/pata_mpc52xx.c from the standard tree, 100% unchanged. As
I said, for the bisect I was using the original, unchanged
torvalds/master tree from git.kernel.org.

> You probably now want to use ata_bmdma_qc_issue() ...

I'm sorry, but if I would know about the details, and would know more
about ATA I would have tried to patch pata_mpc52xx.c by myself.

>  Even better, just send the driver upstream.

It has been there for a long while. You even patched it last summer.


Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
