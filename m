Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7FC367C74
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 02:31:34 +1100 (EST)
In-Reply-To: <Pine.LNX.4.60.0611132312430.3789@poirot.grange>
References: <Pine.LNX.4.60.0611011844570.3736@poirot.grange>
	<Pine.LNX.4.60.0611051526510.4214@poirot.grange>
	<4EC85F22-99A9-4B0F-987C-25B715235320@kernel.crashing.org>
	<Pine.LNX.4.60.0611062048080.6091@poirot.grange>
	<Pine.LNX.4.60.0611132312430.3789@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FF5FF753-C94F-48A6-917E-2D6FB7C681BB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFC (take 3)] linkstation / kurobox support under
	arch/powerpc
Date: Wed, 15 Nov 2006 09:31:43 -0600
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> +CONFIG_CMDLINE="console=ttyS1,57600 root=/dev/sda1 rtc- 
> rs5c372.probe=0,0x32"


Since you mentioned you are using u-boot is there any reason you are  
forcing the cmdline and not just passing it in from u-boot?

- k
