Return-Path: <PeterHuewe@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (Client CN "mout.gmx.net", Issuer "TeleSec ServerPass DE-1" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 442CE2C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 11:00:05 +1100 (EST)
Received: from lamerx.localnet ([84.56.16.139]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MAQ0o-1VPLsw1Zdq-00BYBw for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 01:00:00 +0100
From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [tpmdd-devel] Has anyone a ATMEL TPM Chip on PPC64
 (CONFIG_TCG_ATMEL)?
Date: Tue, 29 Oct 2013 01:03:26 +0100
References: <201310272306.09310.PeterHuewe@gmx.de>
 <526EA6FF.2080401@linux.vnet.ibm.com>
 <20131028234745.GB26666@obsidianresearch.com>
In-Reply-To: <20131028234745.GB26666@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201310290103.26678.PeterHuewe@gmx.de>
Cc: Joel Schopp <jschopp@linux.vnet.ibm.com>, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag, 29. Oktober 2013, 00:47:45 schrieb Jason Gunthorpe:
> On Mon, Oct 28, 2013 at 01:03:43PM -0500, Joel Schopp wrote:
> > On 10/27/2013 05:06 PM, Peter H?we wrote:
> > > Hi,
> > > 
> > > I was wondering if anyone here on this list still has a machine with an
> > > old ATMEL TPM (trusted platform module) lying around?
> > > 
> > >>From the kconfig entry it becomes evident that it was only supported on
> > >>ppc64
> > >>
> > > machines.
> > > 
> > > config TCG_ATMEL
> > > 
> > > 	tristate "Atmel TPM Interface"
> > > 	depends on PPC64 || HAS_IOPORT
> 
> Hurm, that is crazy, because tpm_atmel.h contains an #else block for
> !CONFIG_PPC64. The single major source of complexity in this driver is
> that else block.
> 
Argh, sorry my bad.
Of course it's available on other archs as well, since it's
PPC64 _||_ HAS_IOPORT

d'oh - sorry.


Peter
