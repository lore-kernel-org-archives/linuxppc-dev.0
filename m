Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Vm1M46blzF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 00:29:27 +1000 (AEST)
Date: Tue, 24 Apr 2018 16:29:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, arnd@arndb.de, corbet@lwn.net,
 seroyer@linux.vnet.ibm.com, mrochs@linux.vnet.ibm.com,
 adreznec@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 davem@davemloft.net, linus.walleij@linaro.org,
 akpm@linux-foundation.org, mikey@neuling.org, pombredanne@nexb.com,
 tlfalcon@linux.vnet.ibm.com, msuchanek@suse.de,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 1/1] misc: IBM Virtual Management Channel Driver
Message-ID: <20180424142918.GA2459@kroah.com>
References: <1524494812-60150-1-git-send-email-bryantly@linux.vnet.ibm.com>
 <1524494812-60150-2-git-send-email-bryantly@linux.vnet.ibm.com>
 <c07b14b7-8f34-2ba5-536f-85896ff21661@infradead.org>
 <20180423195310.GA10693@kroah.com>
 <4142fd3b-05eb-d934-bcd3-f8f564e24fa7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4142fd3b-05eb-d934-bcd3-f8f564e24fa7@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2018 at 02:17:28PM -0700, Randy Dunlap wrote:
> On 04/23/18 12:53, Greg KH wrote:
> > On Mon, Apr 23, 2018 at 11:38:18AM -0700, Randy Dunlap wrote:
> >> On 04/23/18 07:46, Bryant G. Ly wrote:
> >>> This driver is a logical device which provides an
> >>> interface between the hypervisor and a management
> >>> partition.
> >>>
> >>> This driver is to be used for the POWER Virtual
> >>> Management Channel Virtual Adapter on the PowerVM
> >>> platform. It provides both request/response and
> >>> async message support through the /dev/ibmvmc node.
> >>>
> >>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> >>> Reviewed-by: Steven Royer <seroyer@linux.vnet.ibm.com>
> >>> Reviewed-by: Adam Reznechek <adreznec@linux.vnet.ibm.com>
> >>> Tested-by: Taylor Jakobson <tjakobs@us.ibm.com>
> >>> Tested-by: Brad Warrum <bwarrum@us.ibm.com>
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >>> ---
> >>>  Documentation/ioctl/ioctl-number.txt  |    1 +
> >>>  Documentation/misc-devices/ibmvmc.txt |  161 +++
> >>>  MAINTAINERS                           |    6 +
> >>>  arch/powerpc/include/asm/hvcall.h     |    1 +
> >>>  drivers/misc/Kconfig                  |   14 +
> >>>  drivers/misc/Makefile                 |    1 +
> >>>  drivers/misc/ibmvmc.c                 | 2415 +++++++++++++++++++++++++++++++++
> >>>  drivers/misc/ibmvmc.h                 |  209 +++
> >>>  8 files changed, 2808 insertions(+)
> >>>  create mode 100644 Documentation/misc-devices/ibmvmc.txt
> >>>  create mode 100644 drivers/misc/ibmvmc.c
> >>>  create mode 100644 drivers/misc/ibmvmc.h
> >>
> >>> diff --git a/Documentation/misc-devices/ibmvmc.txt b/Documentation/misc-devices/ibmvmc.txt
> >>> new file mode 100644
> >>> index 0000000..bae1064
> >>> --- /dev/null
> >>> +++ b/Documentation/misc-devices/ibmvmc.txt
> > 
> > Aren't we doing new documentation in .rst format instead of .txt?
> 
> I am not aware that .rst format is a *requirement* for new documentation.
> 
> ??

Why wouldn't you create new documentation in that format?  Just saves
the step of having to change it again in the future.

thanks,

greg k-h
