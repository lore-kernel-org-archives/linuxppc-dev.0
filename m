Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16421DDE23
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 07:14:56 +1100 (EST)
Subject: Re: kref refcnt and false positives
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1167578178.22068.326.camel@pmac.infradead.org>
References: <200612210901.kBL91MwR027509@hera.kernel.org>
	<1167578178.22068.326.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 07:13:22 +1100
Message-Id: <1167682402.23340.134.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This makes my Maple board very unhappy -- it triggers a WARN_ON() in
> kref_get() lots of times...

Maybe the refounting in prom.c is broken ? I'll have a look.

Ben.
