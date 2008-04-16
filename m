Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55EE9DE041
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 00:00:50 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3GE0k7u002688
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 10:00:46 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3GE0kXH269666
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 10:00:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3GE0kYa018947
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 10:00:46 -0400
Date: Wed, 16 Apr 2008 08:57:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: More patches pushed to powerpc.git master and powerpc-next
	branches
Message-ID: <20080416085723.3f0ec4df@zod.rchland.ibm.com>
In-Reply-To: <18437.62522.276473.12143@cargo.ozlabs.ibm.com>
References: <18437.61934.495516.351438@cargo.ozlabs.ibm.com>
	<18437.62522.276473.12143@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Apr 2008 22:42:34 +1000
Paul Mackerras <paulus@samba.org> wrote:

> I wrote:
> 
> > The following commits are now in the master and powerpc-next branches
> > in the powerpc.git tree.  This includes commits pulled from Josh
> > Boyer's and Olof Johansson's trees.
> 
> Because of a problem caused by a couple of commits in Josh Boyer's
> tree, I have forced the master and powerpc-next branches back to where
> they were until an hour or so ago.  Hopefully no-one has done a pull
> in that time; if anyone has then they will need to do a git pull -f
> when I eventually push the commits out (since they will have different
> IDs).

My "next" and "for-2.6.26" branches are reset and the offending patches
have been dropped.  My apologies for all the trouble.

josh
