Return-Path: <alan.casey5@mail.dcu.ie>
Received: from hawk.dcu.ie (mail.dcu.ie [136.206.1.5])
	by ozlabs.org (Postfix) with ESMTP id F1137DE142
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Aug 2008 19:59:47 +1000 (EST)
Date: Fri, 15 Aug 2008 10:59:43 +0100
Message-ID: <4891711700018ABB@hawk.dcu.ie>
In-Reply-To: <18995644.post@talk.nabble.com>
From: "Alan Casey" <alan.casey5@mail.dcu.ie>
Subject: Re: Linux issues on Xilinx XUPV2P board
To: "wangyanlong" <killyouatonce@gmail.com>,
 linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Reply-To: alan.casey5@mail.dcu.ie
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

  Yes i had a problem with using one of the Linux 2.6.26
  kernel versions on the XUPV2P board where the VGA
  display has not driven correctly, not sure why.
  The Linux 2.6.24 kernel from git.xilinx.com works fine.

  Regards,
  Alan.
  

>-- Original Message --
>Date: Fri, 15 Aug 2008 01:43:37 -0700 (PDT)
>From: wangyanlong <killyouatonce@gmail.com>
>To: linuxppc-embedded@ozlabs.org
>Subject: Re: Linux issues on Xilinx XUPV2P board
>
>
>
>I meet the problem as yours . And  my vga's display is not clear , have
you
>meet this?
>
>Alan Casey wrote:
>> 
>> Hi,
>> 
>>   I have tried running the Linux 2.6.24 and Linux 2.6.26 kernels from

> 
>>   git.xilinx.com on the Xilinx XUPV2P board but have run into a few
>> problems.
>> 
>>   Cross-compiler i use to compile applications was built using Crossto=
ols
>> and
>>   based on gcc 3.3.4. I use Xilinx EDK 7.1 for integrating hardware
>> peripherals
>>   onto the board.
>> 
>>   The problems i've seen are:
>> 
>>   (i) gettimeofday software function returns time of 0 all the time.
>> 
>>   (ii) The Linux 2.6.24 kernel's Xilinx Framebuffer driver and/or the
>> Xilinx
>> 
>>        PLB TFT Controller IP block (plb_tft_cntlr_ref_v1_00_d) does no=
t
>> appear
>> 
>>        to centre the display on a VGA screen properly(vertically offse=
t).
>> 
>>   (iii) 64-bit write/read access to peripheral integrated onto the Xil=
inx
>> 
>>         Virtex-II Pro FPGA either causes a system crash or only lower
part
>> 
>>         of 32-bit data to be written (i.e. lower part of 64-bit data
>> appears
>>         to be mirrored on the upper and lower 32-bits of the system bu=
s).
>>         However, 32-bit write/read access to the peripheral passes as
well
>>         as 64-bit write/read access to the SDRAM memory address space.=

>>         Peripheral interface has been verified to be IBM PLB compliant=

>
>>         via IBM bus functional model simulations. 
>> 
>>    (iv) The Linux 2.6.26 Xilinx Framebuffer driver on the Xilinx XUPV2=
P
>> board
>> 
>>         does not appear to be working - nothing displayed to
>> screen/console
>> 
>>         not switching to framebuffer device on bootup. 
>> 
>>    Just wondering if anybody has seen these issues before and know how=

>to
>>    resolve them?
>> 
>>    Any info. appreciated,
>>    Regards,
>>    Alan.
>> 
>>   
>> 
>> 
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> 
>> 
>
>-- 
>View this message in context: http://www.nabble.com/Linux-issues-on-Xili=
nx-XUPV2P-board-tp18262250p18995644.html
>Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
