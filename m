Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C8DA95C.7060402@dgt-lab.com.pl>
Date: Tue, 12 Mar 2002 08:08:12 +0100
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode
References: <20020308152249.B9AC9109EF@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>In message <3C88CDB2.7070905@dgt-lab.com.pl> you wrote:
>
>>Anyone could send me UPM table for CAS_LATENCY==3. I'm not sure if burst is realy needed. Now its disabled, because I do not have correct UPM table for this.
>>
>
>Browse the PPCBoot sources;  I  added  a  configuration  for  TQM8xxL
>modules   at   66   MHz  (cpu-bus  1:1)  recently;  also,  the  LWMON
>configuration runs at 66 MHz 1:1.
>
OK, thank You. But this UPM table dosen't seem to work with my DIMM.




>




--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
