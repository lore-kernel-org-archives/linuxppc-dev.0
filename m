Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5430DB7BE5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Dec 2009 00:22:43 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBNDEs2H023450
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2009 06:14:54 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBNDMTEQ117458
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2009 06:22:29 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBNDMSQK029451
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2009 06:22:28 -0700
Date: Wed, 23 Dec 2009 08:22:20 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>
Subject: Re: msi / msix on PPC405EX?
Message-ID: <20091223132220.GA6229@zod.rchland.ibm.com>
References: <6680AE1BD102B9419251E785D19F5D030178135A@ExchN1.riedel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6680AE1BD102B9419251E785D19F5D030178135A@ExchN1.riedel.net>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 23, 2009 at 09:50:39AM +0100, Weirich, Bernhard wrote:
>Hello,
>
>I am wondering whether msi / msix should work on PPC405EX. A call to pci_enable_msi returns: -38 / ENOSYS, function not implemented.
>Can someone tell me if I am missing out something or if msi is indeed not implemented on this platform?

It doesn't work there yet, as it has not been implemented.  There are patches
for MSI on 460SX now, and those could probably be leveraged once they're merged.

josh
