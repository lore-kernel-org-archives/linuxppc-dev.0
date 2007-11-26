Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 3173DDDEF9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 18:12:48 +1100 (EST)
Message-ID: <474A71E2.2020005@fz-juelich.de>
Date: Mon, 26 Nov 2007 08:12:34 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: gsk19@bezeqint.net
Subject: Re: MontaVista 4.0.1 on Xilinx ML405 board
References: <20071123185858.DSC68826@mas23.bezeqint.net>
In-Reply-To: <20071123185858.DSC68826@mas23.bezeqint.net>
Content-Type: text/plain;
	charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

lock up the location of the __log_buf in the System.map  and check if
errormessages are stored there in the memory.
check the console device. it must be /dev/ttyULx

Georg



gsk19@bezeqint.net wrote:
> We built a design for ML405 using EDK 9.1.02. EDK also 
> creates linux drivers for MontaVista Pro 4.0.1 (2.6.10).
> The drivers were copied to a clean copy of Pro 4.0.1 and the 
> kernel was built. When we downloaded the kernel to the target 
> and ran it, we got exception. We didn't get any messages on 
> the hyper terminal. 
> We used Tri-Mode Ethernet and UART lite.
> MontaVista checked the integration of EDK 8.2 with ML403. 
> Can you help ?
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   



-------------------------------------------------------------------
-------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender),
Dr. Ulrich Krafft (stellv. Vorsitzender), Dr. Sebastian M. Schmidt
-------------------------------------------------------------------
-------------------------------------------------------------------
