Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 6FA2BDDE07
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 13:44:22 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so4673505wag
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 20:44:21 -0700 (PDT)
Message-ID: <fa686aa40709302044u4eaf097ap576e6364014c8cd7@mail.gmail.com>
Date: Sun, 30 Sep 2007 21:44:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 0/4] Xilinx Virtex support for arch/powerpc
In-Reply-To: <1191206775.10089.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
	<1191206775.10089.10.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/30/07, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Sun, 2007-09-30 at 16:20 -0600, Grant Likely wrote:
> > 2nd version of Xilinx Virtex patches.  I've addressed all the comments
> > that I've received so far.  This series is just the arch/powerpc support
> > code.  I'll send the device driver changes in a seperate series for
> > each driver.
>
> Overall looks pretty darn good.  You dropped the patch to add you as the
> Xilinx maintainer.  Oversight?

I just don't have an OK from Paulus yet.

> Also, the support seems fairly generic but I don't see any ml300.dts or
> ml4xx.dts files.  And the Kconfig files don't select WANT_DEVICE_TREE.
> Are those patches coming later, or do these boards really not need a DTS
> file?

Those patches are coming later along with a defconfig patch.

Thanks Josh!
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
