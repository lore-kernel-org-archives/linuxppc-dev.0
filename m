Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AAF90B7179
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 12:47:44 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06C9CDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 12:47:43 +1000 (EST)
Message-Id: <09185A86-F744-4302-A78A-04E1FFFA32BD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <e9c3a7c20904271349m134ff7f2s9d7901015454cf3d@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
Date: Wed, 10 Jun 2009 21:45:26 -0500
References: <20090424183517.GB23140@ovro.caltech.edu>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<49F608B7.9080409@ovro.caltech.edu>
	<49F60A3A.4060402@freescale.com>
	<49F61416.8040501@ovro.caltech.edu> <49F614FC.70000@freescale.com>
	<20090427204213.GA4960@ovro.caltech.edu>
	<49F619C4.20100@freescale.com>
	<e9c3a7c20904271349m134ff7f2s9d7901015454cf3d@mail.gmail.com>
Cc: David Hawkins <dwh@ovro.caltech.edu>, Ira Snyder <iws@ovro.caltech.edu>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 27, 2009, at 3:49 PM, Dan Williams wrote:

> On Mon, Apr 27, 2009 at 1:47 PM, Timur Tabi <timur@freescale.com>  
> wrote:
>> Adding Kumar to the CC: list, since he might pick up the patch.
>>
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> I agree with taking this through Kumar's tree.

I'm going through patches for .31.. Should I still pick this up?   
Going forward should I pick up fsldma patches?

- k
