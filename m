Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9C22DDED5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 03:33:53 +1000 (EST)
Message-ID: <462E3F79.6050101@freescale.com>
Date: Tue, 24 Apr 2007 12:33:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/4] bootwrapper: Add ppcboot.h.
References: <20070416232553.GB26693@ld0162-tx32.am.freescale.net>	<20070417090342.3E736352658@atlas.denx.de>
	<17965.37623.561459.64174@cargo.ozlabs.ibm.com>
In-Reply-To: <17965.37623.561459.64174@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Wolfgang Denk writes:
> 
> 
>>Shouldn't we finally get this straight and call the file "u-boot.h" as
>>it is called in U-Boot?
> 
> 
> Is it identical to the one in U-Boot?

It's missing the MPC8220 and NX823 bits and the phynum/mode bits for 4xx 
other than 440GP (which I guess were added after the kernel's ppcboot.h 
forked), and u-boot's has been changed to have CONFIG_HAS_ETH1/2/etc. 
rather than a list of targets, but otherwise it appears to be 
functionally identical.

Do you want me to resubmit using the current u-boot file (as well as an 
updated 83xx platform file to define CONFIG_HAS_ETH1)?

-Scott
