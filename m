Return-Path: <filippo.capurso@dave-tech.it>
Received: from dave-tech.it
	(host46-203-static.38-85-b.business.telecomitalia.it [85.38.203.46])
	by ozlabs.org (Postfix) with SMTP id 3A9D8679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Jun 2006 17:32:57 +1000 (EST)
Message-ID: <449A47A4.6030300@dave-tech.it>
Date: Thu, 22 Jun 2006 09:32:52 +0200
From: Filippo Capurso <filippo.capurso@dave-tech.it>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux on Virtex4
References: <821B2170E9E7F04FA38DF7EC21DE48710573FD21@VCAEXCH01.hq.corp.viasat.com>	
	<528646bc0606191638j64448168ia19d6a97ab81e648@mail.gmail.com>	
	<4498F1E7.5010900@dave-tech.it>
	<528646bc0606210055m71277d1fl66dacfa7cd7ed203@mail.gmail.com>
In-Reply-To: <528646bc0606210055m71277d1fl66dacfa7cd7ed203@mail.gmail.com>
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

Hi Grant,

Thank you for your kind answer.

> Yes, I had seen your message; but I'm not an expert on the 4xx mmu.  I
> haven't seen that behaviour on my board.
> 
> Double check your memory ranges.  Have you given the kernel real RAM?
I'll investigate further on that...

Anyway, is your porting to the ML403 intended to work on Xilinx 
reference design? I haven't exactly this design on my Virtex-4 because 
I've remapped the flash memory to the end of the CPU address space in 
order to execute automatically U-Boot after the configuration process... 
also, obviously, I haven't any BRAM on this design (it was mapped at the 
end of the address space).
The only thing that I've done to recompile the kernel for my project is 
replacing the xparameters_ml403.h file with the EDK generated one. Is 
this correct? Other things to do? My aim just now is to get a working 
kernel with serial port support only.
Thank you.

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
