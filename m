Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9CDF01007D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 07:57:30 +1100 (EST)
Message-ID: <1322859439.11728.12.camel@pasglop>
Subject: Re: [PATCH 2/8] 44x/pci: Add a want_sdr flag into ppc4xx_pciex_hwops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Date: Sat, 03 Dec 2011 07:57:19 +1100
In-Reply-To: <1322725164-4391-3-git-send-email-tony@bakeyournoodle.com>
References: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
 <1322725164-4391-3-git-send-email-tony@bakeyournoodle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-01 at 18:39 +1100, Tony Breeds wrote:

> +       if (ppc4xx_pciex_hwops->want_sdr == true) {

	if (ppc4xx_pciex_hwops->want_sdr) {

Please ! This is a boolean after all :-)

Cheers,
Ben.
