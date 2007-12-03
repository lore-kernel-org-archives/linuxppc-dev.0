Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D636ADE058
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 02:15:03 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB3FExWH017850
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 10:14:59 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB3FEpMr168498
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 08:14:51 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB3FEoND024952
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 08:14:50 -0700
Date: Mon, 3 Dec 2007 09:14:48 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: for-2.6.25 branch created in powerpc.git
Message-ID: <20071203091448.6fae31d2@weaponx>
In-Reply-To: <1196658999.13230.197.camel@pasglop>
References: <18259.35326.516899.603549@cargo.ozlabs.ibm.com>
	<1196658999.13230.197.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 03 Dec 2007 16:16:39 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Mon, 2007-12-03 at 15:45 +1100, Paul Mackerras wrote:
> >       [POWERPC] Add xmon function to dump 44x TLB
> 
> That will go via jwb, there's already some updated versions of that in
> my tree.

Just send me an incremental version.  If it's already in Paul's tree, I
don't really see a reason to play the revert and reapply game.

josh
