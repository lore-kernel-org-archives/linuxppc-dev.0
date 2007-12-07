Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8EB57DDEF7
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 14:42:29 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB73gQLx011684
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:42:26 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB73gPvI127332
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 20:42:26 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB73gP5v018707
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 20:42:25 -0700
Date: Thu, 6 Dec 2007 21:39:28 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Reinstate full old-style reference-to-path for v0 dts files
Message-ID: <20071206213928.1f6a2e1f@zod.rchland.ibm.com>
In-Reply-To: <20071207033826.GD26412@localhost.localdomain>
References: <20071207033826.GD26412@localhost.localdomain>
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

On Fri, 7 Dec 2007 14:38:26 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Commit 7c44c2f9cb1cc2df7aacd13decfc4e64b73d1730 broke backwards
> compatibility more badly than I realised.  Contrary to what I thought
> there are in-kernel, in-use dts files which relied on
> references-to-path with paths including a comma, which no longer
> compile after that commit.

There won't be shortly.  I'm reworking them anyway.

josh
