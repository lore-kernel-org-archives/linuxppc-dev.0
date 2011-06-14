Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 40EBAB6FAA
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 22:15:33 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5EC9PCW014911
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 06:09:25 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5ECFDDB157718
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 06:15:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5E6EiHH012180
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 00:14:45 -0600
Date: Tue, 14 Jun 2011 08:16:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michal Simek <monstr@monstr.eu>
Subject: Re: Relocatable kernel for ppc44x
Message-ID: <20110614121636.GB9620@zod.rchland.ibm.com>
References: <4DF74E5D.9020908@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DF74E5D.9020908@monstr.eu>
Cc: linuxppc-dev@ozlabs.org, Suzuki Poulose <suzuki@in.ibm.com>,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 14, 2011 at 02:04:45PM +0200, Michal Simek wrote:
>Hi,
>
>have someone tried to support RELOCATABLE kernel on ppc44x?

Suzuki will be working on this eventually as part of getting kexec/kdump
working for 44x.  I've CC'd him.

josh
