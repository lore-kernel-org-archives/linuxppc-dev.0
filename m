Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F09C0DDE1E
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 23:56:30 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C7A98ED@zch01exm26.fsl.freescale.net>
References: <18099.1109.83340.915328@cargo.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C7A98ED@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FCAE5E05-7F25-436F-963B-B757765D343A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull powerpc.git merge branch
Date: Mon, 6 Aug 2007 08:57:37 -0500
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 6, 2007, at 12:57 AM, Zhang Wei-r63237 wrote:

> Hi, Paul,
>
> How about following patches?
>
> [PATCH 1/2] Add sysdev/pci_quirks.c file into PowerPC architecture  
> with
> ULI chip quirk functions.
> URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040363.html
> [PATCH 2/2] Remove ULI chip quirks functions from MPC8641HPCN and
> MPC8544DS boards.
> URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040364.html
>
> [PATCH 1/3] Add a new member name to structure irq_host
> URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039896.html
> [PATCH 2/3] Add irq host name for all powerpc interrupt controllors.
> URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039897.html
> [PATCH 3/3] Add irq debugfs and virq_mapping for getting the virq
> URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039895.html

These patches aren't fixing any bugs and would be for 2.6.24 at this  
point.

- k
