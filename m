Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFBE0DDF69
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 02:31:53 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1EFVorN008099
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 10:31:50 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1EFVnDv2543808
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 10:31:49 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1EFVmvs012837
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 08:31:49 -0700
Date: Thu, 14 Feb 2008 09:30:14 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] emac/zmii link warnings
Message-ID: <20080214093014.14e71d4e@zod.rchland.ibm.com>
In-Reply-To: <47AA9251.5020007@pikatech.com>
References: <478C336D.2080307@pikatech.com>
	<20080115152748.d0a05e1b.sfr@canb.auug.org.au>
	<478C487D.9050407@pikatech.com> <47AA9251.5020007@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 07 Feb 2008 00:08:33 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Ok, here is my best shot at removing the warnings. It seems to me that 
> functions called from a dev_init section should not be dev_exit.

This seems to fix those specific warnings, but there are others lurking
in some of the other files (rgmii, tah, etc).  We should probably get
those fixed up too.

josh
