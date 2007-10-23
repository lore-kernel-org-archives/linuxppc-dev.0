Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27EC1DDE42
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 22:06:37 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9NC6YZi002877
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 08:06:34 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9NC6YIr117206
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 06:06:34 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9NC6YeD031284
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 06:06:34 -0600
Date: Tue, 23 Oct 2007 07:06:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Re: Please pull from 'for-2.6.24' branch of 4xx tree
Message-ID: <20071023070632.26c54a23@weaponx.rchland.ibm.com>
In-Reply-To: <20071019163119.62eec6f0@weaponx.rchland.ibm.com>
References: <20071019163119.62eec6f0@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 19 Oct 2007 16:31:19 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> Hi Paul,
> 
> Please pull from
> 
>  master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.24
> 
> to pick up a handful of fixes for 4xx.  These are mostly to enable the
> ibm_newemac driver for the various boards.  Since a few patches to the
> driver are needed from Linus' tree, the branch is based off of his
> latest tree as of this morning.

Ping on this?  I'd like to get these into Linus' tree before the merge
window closes so we have somewhat usable 4xx support in arch/powerpc.

josh
