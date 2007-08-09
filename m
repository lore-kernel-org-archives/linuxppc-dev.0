Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4DB0DDE32
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 22:56:21 +1000 (EST)
Date: Thu, 9 Aug 2007 16:56:12 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: jyoung5@us.ibm.com
Subject: Re: Sequoia 440EPx patches not working
Message-ID: <20070809165612.12100334@localhost.localdomain>
In-Reply-To: <1186598710.5459.7.camel@laptop>
References: <1186598710.5459.7.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, vbarshark@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 08 Aug 2007 13:45:10 -0500
Jerone Young wrote:

> Using the Sequoia (AMCC 440EPx) patches recently submitted to the
> list I am unable to boot to fully boot a uImage built with these
> patches under Uboot. It appears to hang in very early boot.
> 
> 
> Here is the output:
> => tftp 400000
> sequoia/uImage ENET Speed is 100 Mbps - FULL duplex connection
> (EMAC0) Using ppc_4xx_eth0
> device TFTP from server 9.53.41.24; our IP address is
> 9.53.41.38 Filename
> 'sequoia/uImage'. Load address:
> 0x400000 Loading:
> #################################################################
> #################################################################
> #################################################################
> #######################
> done Bytes transferred = 1112434 (10f972
> hex) => bootm
> 400000 ## Booting image at
> 00400000 ... Image Name:
> Linux-2.6.23-rc2 Image Type:   PowerPC Linux Kernel Image (gzip
> compressed) Data Size:    1112370 Bytes =  1.1
> MB Load Address:
> 00000000 Entry Point:
> 00000000 Verifying Checksum ...
> OK Uncompressing Kernel Image ... OK 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

This seems to be a wrong image..

Are you using "make zImage" ?

The proper uImage after that command would be smth like cuImage* then...

-- 
Sincerely, Vitaly
