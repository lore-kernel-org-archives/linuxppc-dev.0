Return-Path: <dan.j.williams@intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C848FB7BAE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 03:51:36 +1000 (EST)
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id 52BCFDDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 03:51:35 +1000 (EST)
Message-ID: <4A71DB56.6090005@intel.com>
Date: Thu, 30 Jul 2009 10:41:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: fsldma patches?
References: <97CDF92A-2FAF-445D-B5B0-1D06884F8259@freescale.com>
In-Reply-To: <97CDF92A-2FAF-445D-B5B0-1D06884F8259@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Dan,
> 
> What happened with the set of patches that Ira posted for fsldma?

I have just sent a pull request with the pending backlog of dmaengine 
fixes.  Our discussion of the fsldma slave implementation did not 
conclude in time for me to get a pull request out before the close of 
the 2.6.31 merge window.  I have queued it up for 2.6.32.

--
Dan
