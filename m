Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.249])
	by ozlabs.org (Postfix) with ESMTP id 7625FDDFB6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 06:02:25 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id x43so97106hsb.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 11:02:22 -0800 (PST)
Message-ID: <fa686aa40802211102i7f636447hfca0f8e1673042a5@mail.gmail.com>
Date: Thu, 21 Feb 2008 12:02:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: Xilinx PowerPC
In-Reply-To: <20080221175025.7817BBD8057@mail91-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47BD212B.6090809@dlasys.net>
	<20080221175025.7817BBD8057@mail91-sin.bigfish.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2008 at 10:50 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>  >     Step 2).
>  >              the code in arch/powerpc/???? is the devicetree equvalent
>  to
>  >              arch/ppc/platforms/4xx/xilinx_ml410.c
>  http://git.xilinx.com/linux-2.6-xlnx.git contains a preliminary stab at
>  the bootcode for Virtex.  I've been using this for a while with
>  ARCH=powerpc.  There isn't really much need for board specific platform
>  code: This should (I think) be handled by the device tree.  All of this
>  is still pretty preliminary at the moment however.  The big problem with
>  the boot code in the Xilinx tree is that you need to be able to allocate
>  memory in order to parse the device tree in order to figure out how much
>  memory you have.  I just haven't rewritten the code to use libfdt, which
>  can query the device tree without memory allocation yet.  Grant has a
>  slightly different scheme in his tree, but it works as well.  Generally
>  I've been more focused on avoiding u-boot, whereas Grant has been using
>  u-boot exclusively, I think.

Actually, I'm not using u-boot at all.  I've reworked the 'raw' image
target to use libfdt and properly initialize the cache and stuff.
I'll be merging it in the .26 merge window.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
