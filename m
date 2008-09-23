Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18EA7DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 22:21:51 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8NCLjYJ016539
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 08:21:45 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8NCLj4t267578
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 08:21:45 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8NCLjhp013625
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 08:21:45 -0400
Date: Tue, 23 Sep 2008 08:21:43 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Victor Gallardo" <vgallardo@amcc.com>
Subject: Re: [PATCH v2] Add AMCC Arches eval board support to platforms/44x
Message-ID: <20080923082143.7b00bfbc@zod.rchland.ibm.com>
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D6050D1CEF@SDCEXCHANGE01.ad.amcc.com>
References: <20080919133936.27d2a09f@zod.rchland.ibm.com>
	<0CA0A16855646F4FA96D25A158E299D6050D1CEF@SDCEXCHANGE01.ad.amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 22 Sep 2008 16:54:46 -0700
"Victor Gallardo" <vgallardo@amcc.com> wrote:

> Hi Josh, 
> 
> >
> >You need to look in the 'next' branch.
> >
> > http://git.kernel.org/?p=linux/kernel/git/jwboyer/powerpc-4xx.git;a=tree;f=arch/powerpc/platforms/44x;h=c5cae8d37f170193ed45b7b76e3cb2cbb8be927a;hb=next
> >
> >josh
> 
> I am not sure how to get your next branch.
> 
> I usually just use the following command.
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git linux-ppc4xx

This is fine.

> How do I get the next branch?

'git branch -r' will show you all the remote branches.  To check out
the 'next' branch, simply do:

'git checkout -b next origin/next'

My setup is slightly different because I clone Linus' tree and add
Paul's and my own as remotes using 'git remote add'.  But that's just
how I prefer to operate, and there is nothing wrong with cloning my
tree itself if you are only looking for 4xx changes.

josh
