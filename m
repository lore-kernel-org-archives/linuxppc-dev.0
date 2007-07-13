Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 506E7DDE1C
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 07:15:12 +1000 (EST)
Date: Sat, 14 Jul 2007 07:15:11 +1000
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: hvc_iseries not working
Message-ID: <20070713211511.GQ10345@bakeyournoodle.com>
References: <20070713170540.GA1987@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070713170540.GA1987@aepfle.de>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 13, 2007 at 07:05:40PM +0200, Olaf Hering wrote:

Hi Olaf,
 
> 2.6.21 arch/powerpc/configs/iseries_defconfig works on an i825 with v5r4
> 2.6.22 arch/powerpc/configs/iseries_defconfig does not. But it works on
> a i820 with v5r3.
> 2.6.22 boots ok with CONFIG_VIOCONS

Rats!
	Can you send me the complete dmesg and .config for each kernel.
I'll poke at this whne I get to work on Monday.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
