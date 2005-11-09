Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 6E5936868F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 00:12:38 +1100 (EST)
Message-ID: <4371F5C3.40805@ru.mvista.com>
Date: Wed, 09 Nov 2005 16:12:35 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Mike Rapoport <mike@compulab.co.il>
References: <4371A513.6040409@compulab.co.il>
In-Reply-To: <4371A513.6040409@compulab.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Using SMC on MPC8272 based board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mike Rapoport wrote:
> I have a custom board based on MPC8272 and I don't succeed to enable SMC 
> serial port. I'm running Linux 2.6.12.3 with CPM serial drivers from 
> 2.6.13.2.
> When I configure the kernel to use one or two SCCs, with or without 
> serial console everything works fine. But if I configure the kernel to 
> support SMC serial port, I see nothing at the SMC port.
> I've noticed that SMC1 pins are configured at port D (as in MPC8260), 
> but MPC8272 has the SMC1 on the port C. I've changed the pins assignment 
> to use the port C pins, but it didn't help.
> When I enable support for serial console on SCC/SMC port, the system 
> hangs when the SMC is enabled.
> When I don't enable support for serial console on SCC/SMC port, the 
> system boots OK, but there's nothing on the SMC port.
> 

That is because (at least if you use "pure" 8272) the board does have 
SCC1 and SCC4 for UART0 and UART1 respectively. SMC could not be used as 
serial port on this board.

-- 
Sincerely,
Vitaly
