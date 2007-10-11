Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 374FADDEBB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 22:49:58 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9BCnjoh001838
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 08:49:45 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9BCnjcj116302
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 08:49:45 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9BCnZYm021120
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 08:49:35 -0400
Subject: Re: powerpc commits for 2.6.24
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
References: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 07:47:06 -0500
Message-Id: <1192106826.5534.114.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-10-11 at 22:30 +1000, Paul Mackerras wrote:
> Below is the list of commits that I plan to ask Linus to pull
> tomorrow.  This is the last call for anything else or for objections
> to any of these commits going in.  These commits are in powerpc.git on
> the master and for-2.6.24 branches.

Hi Paul,

Could you pull from:

master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.24

to pick up some Xilinx changes from Grant?  I'm also hoping to get
Stefan's 405EX changes in soon.

josh
