Return-Path: <sameo@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by ozlabs.org (Postfix) with ESMTP id 60E13B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 02:13:23 +1100 (EST)
Date: Thu, 9 Dec 2010 16:03:12 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/2] video, sm501: add OF binding to support SM501
Message-ID: <20101209150311.GO8884@sortiz-mobl>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<20101208053635.GB31508@linux-sh.org> <4D007C09.3040308@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D007C09.3040308@denx.de>
Cc: linux-fbdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	linuxppc-dev@lists.ozlabs.org, Ben Dooks <ben-linux@fluff.org>,
	devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Heiko,

On Thu, Dec 09, 2010 at 07:49:45AM +0100, Heiko Schocher wrote:
> Hello Paul,
> 
> Paul Mundt wrote:
> > On Sat, Dec 04, 2010 at 09:23:47AM +0100, Heiko Schocher wrote:
> >> - add binding to OF, compatible name "smi,sm501"
> >>
> [...]
> >>  Documentation/kernel-parameters.txt          |    7 +
> >>  Documentation/powerpc/dts-bindings/sm501.txt |   30 +++
> >>  drivers/mfd/sm501.c                          |  141 ++++++++------
> >>  drivers/video/sm501fb.c                      |  264 +++++++++++++++++---------
> >>  include/linux/sm501.h                        |    8 +
> >>  5 files changed, 299 insertions(+), 151 deletions(-)
> >>  create mode 100644 Documentation/powerpc/dts-bindings/sm501.txt
> >>
> > Given that this is all SM501 dependent, is there some particular reason
> > why you neglected to Cc the author or the MFD folks?
> 
> Hups, sorry! No, there is no reason, thanks for detecting this.
> 
> Hmm.. couldn;t find a MFD maillinglist?
We use lkml. Could you please re-send the patch to me ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
