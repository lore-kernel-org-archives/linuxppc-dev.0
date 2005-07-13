Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 117FB67A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 04:05:26 +1000 (EST)
Message-ID: <42D557E3.9060503@ru.mvista.com>
Date: Wed, 13 Jul 2005 22:05:23 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Subject: UART problem on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!
Do anyone have 2-nd UART port working on MPC8272ADS?

The target boots OK via both UARTs as console, but any attempt to 
transmit/receive data via the other port have failed.
A quick lookup results that ...init_scc is called only in `console` 
case. After addition of this call to the cpm_uart_startup (just for 
instance) transmit from the target occur, but with only half of data. I 
tried various pin settings including working combinations from the old 
uart driver but with the same result.

I guess that 8xx that are also handled by this driver may behave 
likewise, so any information whether cpm_uart driver works well  (or 
not)  on 8xx is also valuable.

Any ideas how to solve this or concerning possible reasons of such 
behavior are greatly appreciated.

-- 
Sincerely, 
Vitaly
