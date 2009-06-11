Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4BDF4B715D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 01:17:53 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id E4982DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 01:17:52 +1000 (EST)
Date: Thu, 11 Jun 2009 08:17:50 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
Message-ID: <20090611151750.GB9323@ovro.caltech.edu>
References: <D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<49F608B7.9080409@ovro.caltech.edu>
	<49F60A3A.4060402@freescale.com>
	<49F61416.8040501@ovro.caltech.edu> <49F614FC.70000@freescale.com>
	<20090427204213.GA4960@ovro.caltech.edu>
	<49F619C4.20100@freescale.com>
	<e9c3a7c20904271349m134ff7f2s9d7901015454cf3d@mail.gmail.com>
	<09185A86-F744-4302-A78A-04E1FFFA32BD@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09185A86-F744-4302-A78A-04E1FFFA32BD@kernel.crashing.org>
Cc: David Hawkins <dwh@ovro.caltech.edu>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2009 at 09:45:26PM -0500, Kumar Gala wrote:
>
> On Apr 27, 2009, at 3:49 PM, Dan Williams wrote:
>
>> On Mon, Apr 27, 2009 at 1:47 PM, Timur Tabi <timur@freescale.com>  
>> wrote:
>>> Adding Kumar to the CC: list, since he might pick up the patch.
>>>
>>
>> Acked-by: Dan Williams <dan.j.williams@intel.com>
>>
>> I agree with taking this through Kumar's tree.
>
> I'm going through patches for .31.. Should I still pick this up?  Going 
> forward should I pick up fsldma patches?
>

I'm fine with that, but you should probably talk to Li Yang (added to
CC). He's gotten in contact with me a few times recently.

In addition to the PCI Read Multiple patch, I've posted a few more
fsldma patches to ppcdev recently:

fsldma: enable external start for the 83xx controller
fsldma: do not clear bandwidth control bits on the 83xx controller
fsldma: Add DMA_SLAVE support

The first two are very straightforward. The third probably needs some
review before it can be picked up, though. It is well tested, I've been
using it for a few weeks without issues.

Thanks,
Ira
