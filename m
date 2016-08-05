Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5J393gDgzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 17:14:45 +1000 (AEST)
Date: Fri, 5 Aug 2016 09:14:41 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Borislav Petkov <bp@alien8.de>
Cc: york sun <york.sun@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
 "oss@buserror.net" <oss@buserror.net>, Stuart Yoder <stuart.yoder@nxp.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kevin Hao <haokexin@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
Message-ID: <20160805071441.enq2yascwjtf45u5@c203.arch.suse.de>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
 <877fbvkhi3.fsf@concordia.ellerman.id.au>
 <AM4PR0401MB17321DA6630E78AF2ED7DA269A180@AM4PR0401MB1732.eurprd04.prod.outlook.com>
 <20160805070126.GE25630@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160805070126.GE25630@nazgul.tnic>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2016 at 09:01:26AM +0200, Borislav Petkov wrote:
> On Fri, Aug 05, 2016 at 04:26:26AM +0000, york sun wrote:
> > I don't have deep knowledge of this driver. What I am trying is to 
> > separate the common DDR part and share it with ARM platforms. Along the 
> > way, I found the compiling error if build a module. If exposing these 
> > functions becomes a concern, I can live without it.
> 
> Perhaps you or Johannes could fix this properly to use pci_get_device()
> as the rest of the EDAC drivers do, instead of exporting core PCI
> functions...

I can give it a shot, but I don't have too much spare time atm and no hardware
to test, so it'll have a strong RFC smell attached to it.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
