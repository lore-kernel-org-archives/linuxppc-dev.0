Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2CE8CDDDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Dec 2007 06:20:27 +1100 (EST)
Date: Mon, 24 Dec 2007 13:27:29 -0600
From: Olof Johansson <olof@lixom.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: Build breakage on powerpc with 2.6.24-rc6-mm1
Message-ID: <20071224192729.GA3122@lixom.net>
References: <20071223224158.GA7975@linux.vnet.ibm.com>
	<20071224134353.c00fc231.sfr@canb.auug.org.au>
	<20071224044912.GA10690@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071224044912.GA10690@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
	balbir@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 23, 2007 at 08:49:12PM -0800, Greg KH wrote:
> > Hi Greg, do you even build with your patches applied?
> 
> For the power architecture, no, I do not.  I used to, but my cross-build
> box died and I haven't taken the time to set it all up again.

Crosstool makes it really easy. It's demo-powerpc-970.sh will build a
toolchain that can build both 32- and 64-bit powerpc kernels. It's got
a demo-s390.sh as well, but I haven't tried that one myself.


-Olof
