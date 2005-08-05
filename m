Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id D9CCD67E58
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 22:10:29 +1000 (EST)
Message-ID: <42F35734.2010907@ru.mvista.com>
Date: Fri, 05 Aug 2005 16:10:28 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: apoorv sangal <apoorvsangal@gmail.com>
References: <a796693605080503383ce43419@mail.gmail.com>
In-Reply-To: <a796693605080503383ce43419@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: apoorv sangal <apoorv_sangal@satyam.com>, vikrant_basotra@satyam.com,
	nishant_galange@satyam.com, sibi_mathew@satyam.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: Problem related to root filesystem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

apoorv sangal wrote:

>Hi All,
>	I am porting Linux on the custom board PMC8266 (having MPC8266
>microprocessor) based on the ADS8260 board.I am using ELDK1.1.1 and
>Linux2.4.24.
>
>I am trying to load JFFS2 filesystem , the JFFS2 filesystem image is
>at address 0xFC160000 and the flash size is 32mb
>
>I am getting the following messages:-
>physmap flash device: 2000000 at fc160000
>
>CFI: Found no Physically mapped flash device at location zero
>
>  
>
Check if flash-relative buswidth and interleave has been configured 
within CONFIG_MTD_CFI_GEOMETRY.

-- 
Sincerely, 
Vitaly
