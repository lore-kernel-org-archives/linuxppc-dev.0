Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.232])
	by ozlabs.org (Postfix) with ESMTP id 6B364DE02E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 05:05:20 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so3373466qbc.37
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jul 2008 12:05:18 -0700 (PDT)
Date: Thu, 3 Jul 2008 13:04:40 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Thomas Maenner <tmaenner@aehr.com>
Subject: Re: Need stable 2.6 kernel for TQM823L
Message-ID: <20080703190440.GA3098@secretlab.ca>
References: <200807021418.13596.tmaenner@aehr.com>
	<20080703055819.GB643@secretlab.ca>
	<200807031159.30434.tmaenner@aehr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200807031159.30434.tmaenner@aehr.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2008 at 11:59:29AM -0700, Thomas Maenner wrote:
> > $ ls arch/powerpc/boot/dts/tqm*
> > arch/powerpc/boot/dts/tqm5200.dts  arch/powerpc/boot/dts/tqm8555.dts
> > arch/powerpc/boot/dts/tqm8540.dts  arch/powerpc/boot/dts/tqm8560.dts
> > arch/powerpc/boot/dts/tqm8541.dts
> >
> however, I found config files in the ppc tree:
> ls arch/ppc/configs/TQM8*
> arch/ppc/configs/TQM823L_defconfig  
> arch/ppc/configs/TQM850L_defconfig
> arch/ppc/configs/TQM8260_defconfig 
> arch/ppc/configs/TQM860L_defconfig
> 
> Is this stuff still working?
> Do I still need to create a device tree?

arch/ppc is depreciated and will disappear in 2.6.27.  I don't know if
anyone is actively keeping 8xx support working in arch/ppc so you may
experience significant breakage.

g.
