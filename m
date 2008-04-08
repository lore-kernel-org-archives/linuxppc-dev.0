Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 9184BDDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 14:21:06 +1000 (EST)
Date: Tue, 8 Apr 2008 00:21:03 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Valentine Barshak" <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 44x: use machine_device_initcall() instead
	ofdevice_initcall() for warp_nand
Message-ID: <20080408002103.1b66aeea@lappy.seanm.ca>
In-Reply-To: <20080404182437.GA18185@ru.mvista.com>
References: <20080404182437.GA18185@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 4 Apr 2008 22:24:37 +0400
"Valentine Barshak" <vbarshak@ru.mvista.com> wrote:

> With a multiplatform kernel, once built we always have
> warp_setup_nand_flash() called and NDFC probed, no matter what
> machine we actually run on. This potentially can cause problems (such
> as kernel crash), since NDFC is probed at a warp-predefined address.
> Using machine_device_initcall() NAND devices are registered if we run
> on a warp only.

Thanks for catching that. I have gotten *way* behind on my email and am
only reading this now.

Cheers,
  Sean
