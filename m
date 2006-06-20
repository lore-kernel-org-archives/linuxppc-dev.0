Return-Path: <filippo.capurso@dave-tech.it>
Received: from dave-tech.it
	(host46-203-static.38-85-b.business.telecomitalia.it [85.38.203.46])
	by ozlabs.org (Postfix) with SMTP id 1639567B2D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 19:04:39 +1000 (EST)
Message-ID: <4497BA1E.5090603@dave-tech.it>
Date: Tue, 20 Jun 2006 11:04:30 +0200
From: Filippo Capurso - DAVE srl <filippo.capurso@dave-tech.it>
MIME-Version: 1.0
To: grave@ipno.in2p3.fr
Subject: Re: Gb Ethernet on xilinx gemac IP
References: <1150785936.17197.9.camel@ipnnarval>
In-Reply-To: <1150785936.17197.9.camel@ipnnarval>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Reply-To: filippo.capurso@dave-tech.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Xavier,

I'm trying to get running linux 2.6.17 on my ML403 board (Virtex-4) but 
I'm having some trouble with the MMU initialization...
This my message to the ML:

http://ozlabs.org/pipermail/linuxppc-embedded/2006-June/023321.html

Did you have similar problems? Have you any idea that could help me?
Thank you so much.

About your question:

Xavier Grave ha scritto:
> Hi,
> 
> I'm currently running linux with 10/100 MBits xilinx ethernet driver. I
> have a memec 2VP20 evaluation board.
> We have bought a PCOM2 module in order to have a Gb PHY. I have
> implemented an hardware to handle it but whatever linux version I take
> (2.4 from denx web site, 2.6.17 from kernel.org), I can't configure a Gb
> ethernet driver. And the 10/100 driver don't configure my Gb PHY...
> 
> I have compiled my linux kernel based on the ml300 configuration default
> config.
> 
> Does anyone has an idea ?
This is a patch for ML403 board, it adds the linux 2.6 driver for TEMAC.

http://ozlabs.org/pipermail/linuxppc-embedded/2006-March/022365.html

Hope this helps.

> 
> Thanks, xavier
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

Regards,

Filippo Capurso

-- 

DAVE Srl - Electronics System House
via Forniz 2/1
33080 Porcia (PN) - Italy
Telephone: +39.0434.921215
Telefax: +39.0434.1994030
Freefax: +39.02.700520062
web: www.dave-tech.it
e-mail: filippo.capurso@dave-tech.it
how to reach us: http://mail.map24.com/dave
