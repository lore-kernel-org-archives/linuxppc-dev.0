Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5E0FDDE3B
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 09:00:03 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l17Lxwvg016437
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 16:59:58 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l17LxwRv193230
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 16:59:58 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l17LxvQK016974
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 16:59:57 -0500
Date: Wed, 7 Feb 2007 15:59:57 -0600
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
Message-ID: <20070207215957.GD5616@austin.ibm.com>
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net> <45C90A6E.3040302@freescale.com>
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
	<1170805102.2620.264.camel@localhost.localdomain>
	<0C529499-B766-4D3A-8340-361BB1B461D3@kernel.crashing.org>
	<45C9151E.70201@freescale.com> <20070207000326.GA26024@lixom.net>
	<45C9177B.4050308@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45C9177B.4050308@freescale.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 06, 2007 at 06:04:11PM -0600, Timur Tabi wrote:
> Olof Johansson wrote:
> 
> > On some IBM machines the progress will also print the status on the hardware
> > maintenance console's status line for the partition/machine in question.
> 
> Ah, yes, the HMC.
> 
> Looking at the code, there doesn't appear to be much rhyme or reason as to when 
> ppc_md.progress() is called, but it is called from quite a few files.
> 
> Is there any reason why we can't just re-route printk() to HMC?

Yes.

The HMC progress display is the "same as" the LED's 
i.e. one line of 30 or 40 chars. Its enough to tell you 
the kernel version you've booted, or if the machine is
stuck in firmware. but that's about it. 

--linas
