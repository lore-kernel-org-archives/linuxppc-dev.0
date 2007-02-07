Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id DB642DDEE1
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 11:04:14 +1100 (EST)
Message-ID: <45C9177B.4050308@freescale.com>
Date: Tue, 06 Feb 2007 18:04:11 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net> <45C90A6E.3040302@freescale.com>
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
	<1170805102.2620.264.camel@localhost.localdomain>
	<0C529499-B766-4D3A-8340-361BB1B461D3@kernel.crashing.org>
	<45C9151E.70201@freescale.com> <20070207000326.GA26024@lixom.net>
In-Reply-To: <20070207000326.GA26024@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

> On some IBM machines the progress will also print the status on the hardware
> maintenance console's status line for the partition/machine in question.

Ah, yes, the HMC.

Looking at the code, there doesn't appear to be much rhyme or reason as to when 
ppc_md.progress() is called, but it is called from quite a few files.

Is there any reason why we can't just re-route printk() to HMC?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
