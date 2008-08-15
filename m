Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8F58DDE2BD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Aug 2008 21:35:06 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KTxa9-0001fB-Av
	for linuxppc-embedded@ozlabs.org; Fri, 15 Aug 2008 04:35:01 -0700
Message-ID: <18997255.post@talk.nabble.com>
Date: Fri, 15 Aug 2008 04:35:01 -0700 (PDT)
From: wangyanlong <killyouatonce@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux issues on Xilinx XUPV2P board
In-Reply-To: <4891711700018ABB@hawk.dcu.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <4858FDD100015AFE@hawk.dcu.ie> <18995644.post@talk.nabble.com>
	<4891711700018ABB@hawk.dcu.ie>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Alan 
  I dow load the kernel from "
http://git.xilinx.com/cgi-bin/gitweb.cgi?p=linux-2.6-xlnx.git;a=summary "

Merge ../../linux-2.6 into 2.6.26-merge  master  commit | commitdiff | tree
| snapshot
  
this version ,but it not work well,which version you downloaded?

Many thanks
yanlong
 

Alan Casey wrote:
> 
> Hi,
> 
>   Yes i had a problem with using one of the Linux 2.6.26
>   kernel versions on the XUPV2P board where the VGA
>   display has not driven correctly, not sure why.
>   The Linux 2.6.24 kernel from git.xilinx.com works fine.
> 
>   Regards,
>   Alan.
>   
> 
>>-- Original Message --
>>Date: Fri, 15 Aug 2008 01:43:37 -0700 (PDT)
>>From: wangyanlong <killyouatonce@gmail.com>
>>To: linuxppc-embedded@ozlabs.org
>>Subject: Re: Linux issues on Xilinx XUPV2P board
>>
>>
>>
>>I meet the problem as yours . And  my vga's display is not clear , have
> you
>>meet this?
>>
>>Alan Casey wrote:
>>> 
>>> Hi,
>>> 
>>>   I have tried running the Linux 2.6.24 and Linux 2.6.26 kernels from
> 
>> 
>>>   git.xilinx.com on the Xilinx XUPV2P board but have run into a few
>>> problems.
>>> 
>>>   Cross-compiler i use to compile applications was built using
>>> Crosstools
>>> and
>>>   based on gcc 3.3.4. I use Xilinx EDK 7.1 for integrating hardware
>>> peripherals
>>>   onto the board.
>>> 
>>>   The problems i've seen are:
>>> 
>>>   (i) gettimeofday software function returns time of 0 all the time.
>>> 
>>>   (ii) The Linux 2.6.24 kernel's Xilinx Framebuffer driver and/or the
>>> Xilinx
>>> 
>>>        PLB TFT Controller IP block (plb_tft_cntlr_ref_v1_00_d) does not
>>> appear
>>> 
>>>        to centre the display on a VGA screen properly(vertically
>>> offset).
>>> 
>>>   (iii) 64-bit write/read access to peripheral integrated onto the
>>> Xilinx
>>> 
>>>         Virtex-II Pro FPGA either causes a system crash or only lower
> part
>>> 
>>>         of 32-bit data to be written (i.e. lower part of 64-bit data
>>> appears
>>>         to be mirrored on the upper and lower 32-bits of the system
>>> bus).
>>>         However, 32-bit write/read access to the peripheral passes as
> well
>>>         as 64-bit write/read access to the SDRAM memory address space.
>>>         Peripheral interface has been verified to be IBM PLB compliant
>>
>>>         via IBM bus functional model simulations. 
>>> 
>>>    (iv) The Linux 2.6.26 Xilinx Framebuffer driver on the Xilinx XUPV2P
>>> board
>>> 
>>>         does not appear to be working - nothing displayed to
>>> screen/console
>>> 
>>>         not switching to framebuffer device on bootup. 
>>> 
>>>    Just wondering if anybody has seen these issues before and know how
>>to
>>>    resolve them?
>>> 
>>>    Any info. appreciated,
>>>    Regards,
>>>    Alan.
>>> 
>>>   
>>> 
>>> 
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>> 
>>> 
>>
>>-- 
>>View this message in context:
http://www.nabble.com/Linux-issues-on-Xilinx-XUPV2P-board-tp18262250p18995644.html
>>Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>
>>_______________________________________________
>>Linuxppc-embedded mailing list
>>Linuxppc-embedded@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Linux-issues-on-Xilinx-XUPV2P-board-tp18262250p18997255.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
