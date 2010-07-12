Return-Path: <david-b@pacbell.net>
Received: from n2-vm1.bullet.mail.gq1.yahoo.com
	(n2-vm1.bullet.mail.gq1.yahoo.com [67.195.23.155])
	by ozlabs.org (Postfix) with SMTP id 6E467B6F01
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 09:55:13 +1000 (EST)
Message-ID: <582531.52335.qm@web180310.mail.gq1.yahoo.com>
Date: Mon, 12 Jul 2010 16:55:11 -0700 (PDT)
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/9 v1.01] Add Synopsys DesignWare HS USB OTG Controller
	driver.
To: linux-usb@vger.kernel.org, Fushen Chen <fchen@apm.com>
In-Reply-To: <12789766042434-git-send-email-fchen@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, chuck@theptrgroup.com, gregkh@suse.de,
	Mark Miesfeld <mmiesfeld@apm.com>, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please remove all the changes not related to
this Synopsis IP ... and make the OTG functionality
key on the generic OTG symbol, not a DW-specific one.
