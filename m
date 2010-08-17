Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 5A72EB70D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 08:23:02 +1000 (EST)
Date: Tue, 17 Aug 2010 15:22:59 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: "make uImage" issue with new kernels
Message-ID: <20100817222259.GD5263@ovro.caltech.edu>
References: <5c9e5627d7150addd7801c637a8867d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5c9e5627d7150addd7801c637a8867d8@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 17, 2010 at 03:05:05PM -0700, Tirumala Marri wrote:
> I am seeing weird issue with latest  kernel. “make uImage” failes with “no
> rule to make target” error message.
> 
> Has anything changed recently ?
> 
> 
> 
> -----------msg --------
> 
> {tmarri@svdclab61}> make 44x/canyonlands_defconfig
> 
> #
> 
> # configuration written to .config
> 
> #
> 
> {tmarri@svdclab61}> make uImage
> 
> scripts/kconfig/conf --silentoldconfig arch/powerpc/Kconfig
> 
> make: *** No rule to make target `uImage'.  Stop.
> 
> {tmarri@svdclab61}>
> 

I saw a patch to fix this a few days ago. A typo was introduced in the
Makefile. The patch hasn't made it into mainline yet, so for now try
'make uImaged' instead. I'm sure the fix will be merged soon.

Ira
