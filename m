Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E72767CF9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jul 2005 04:14:19 +1000 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17121.14182.92600.906359@home1.localdomain>
Date: Fri, 22 Jul 2005 21:13:58 +0300
To: Raphael Bossek <raphael.bossek@gmx.de>
In-Reply-To: <42E0B826.2070800@gmx.de>
References: <42E0B826.2070800@gmx.de>
Cc: debian-embedded@lists.debian.org, linuxppc-embedded@ozlabs.org
Subject: Re: Experiences with Debian Sarge on MPC8xx ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Try to change cache line size to zero in arch/ppc/kernel/cputable.c

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
