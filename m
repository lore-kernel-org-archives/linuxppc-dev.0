Return-Path: <dan.j.williams@gmail.com>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id EEA47DDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 06:55:04 +1000 (EST)
Received: by gxk20 with SMTP id 20so319905gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 13:55:02 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <49F619C4.20100@freescale.com>
References: <20090424183517.GB23140@ovro.caltech.edu>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<49F608B7.9080409@ovro.caltech.edu> <49F60A3A.4060402@freescale.com>
	<49F61416.8040501@ovro.caltech.edu> <49F614FC.70000@freescale.com>
	<20090427204213.GA4960@ovro.caltech.edu>
	<49F619C4.20100@freescale.com>
Date: Mon, 27 Apr 2009 13:49:36 -0700
Message-ID: <e9c3a7c20904271349m134ff7f2s9d7901015454cf3d@mail.gmail.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
From: Dan Williams <dan.j.williams@intel.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Hawkins <dwh@ovro.caltech.edu>, Ira Snyder <iws@ovro.caltech.edu>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 1:47 PM, Timur Tabi <timur@freescale.com> wrote:
> Adding Kumar to the CC: list, since he might pick up the patch.
>

Acked-by: Dan Williams <dan.j.williams@intel.com>

I agree with taking this through Kumar's tree.
