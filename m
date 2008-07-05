Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 74F86DDEDC
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 21:34:28 +1000 (EST)
Message-ID: <486F5C53.10801@scram.de>
Date: Sat, 05 Jul 2008 13:34:43 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: New fsl device bindings file
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<486D1A58.8010403@freescale.com>
In-Reply-To: <486D1A58.8010403@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

>> I'm going to move all the Freescale SoC related bindings into this new 
>> file.  One of the aspects of the new file is we will NOT having an 
>> ordinal heading index.
> 
> How about splitting up like this:
> 
> Documentation/powerpc/device-tree/fsl/cpm.txt
> Documentation/powerpc/device-tree/fsl/cpm/uart.txt
> Documentation/powerpc/device-tree/fsl/tsec.txt
> Documentation/powerpc/device-tree/interrupts.txt
> Documentation/powerpc/device-tree/dtb.txt

Sounds reasonable.

Thanks,
Jochen
