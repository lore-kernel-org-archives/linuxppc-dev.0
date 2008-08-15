Return-Path: <alan.casey5@mail.dcu.ie>
Received: from hawk.dcu.ie (mail.dcu.ie [136.206.1.5])
	by ozlabs.org (Postfix) with ESMTP id DDB7FDE276
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Aug 2008 22:34:32 +1000 (EST)
Date: Fri, 15 Aug 2008 13:34:28 +0100
Message-ID: <4891711700018E59@hawk.dcu.ie>
In-Reply-To: <18997255.post@talk.nabble.com>
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

  I used version 2.6.24. Current version is 2.6.26+ but im
  not sure how to download previous versions from the git
  tree, there should be some info at http://git.xilinx.com
  about how to do this.

  Regards,
  Alan.

>-- Original Message --
>Date: Fri, 15 Aug 2008 04:35:01 -0700 (PDT)
>From: wangyanlong <killyouatonce@gmail.com>
>To: linuxppc-embedded@ozlabs.org
>Subject: Re: Linux issues on Xilinx XUPV2P board
>
>
>
>Hi Alan 
>  I dow load the kernel from "
>http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-xlnx.git;a=3Dsumm=
ary
"
>
>Merge ../../linux-2.6 into 2.6.26-merge  master  commit | commitdiff | t=
ree
>| snapshot
>  
>this version ,but it not work well,which version you downloaded?
>
>Many thanks
>yanlong
> 
>
>Alan Casey wrote:
>> 
>> Hi,
>> 
>>   Yes i had a problem with using one of the Linux 2.6.26
>>   kernel versions on the XUPV2P board where the VGA
>>   display has not driven correctly, not sure why.
>>   The Linux 2.6.24 kernel from git.xilinx.com works fine.
>> 
>>   Regards,
>>   Alan.
>>   
>> 
>>>-- Original Message --
>>>Date: Fri, 15 Aug 2008 01:43:37 -0700 (PDT)
>>>From: wangyanlong <killyouatonce@gmail.com>
>>>To: linuxppc-embedded@ozlabs.org
>>>Subject: Re: Linux issues on Xilinx XUPV2P board
>>>
>>>
>>>
>>>I meet the problem as yours . And  my vga's display is not clear , hav=
e
>> you
>>>meet this?
>>>
>>>Alan Casey wrote:
>>>> 
>>>> Hi,
>>>> 
>>>>   I have tried running the Linux 2.6.24 and Linux 2.6.26 kernels fro=
m
>> 
>>> 
>>>>   git.xilinx.com on the Xilinx XUPV2P board but have run into a few
>>>> problems.
>>>> 
>>>>   Cross-compiler i use to compile applications was built using
>>>> Crosstools
>>>> and
>>>>   based on gcc 3.3.4. I use Xilinx EDK 7.1 for integrating hardware
>>>> peripherals
>>>>   onto the board.
>>>> 
>>>>   The problems i've seen are:
>>>> 
>>>>   (i) gettimeofday software function returns time of 0 all the time.=

>>>> 
>>>>   (ii) The Linux 2.6.24 kernel's Xilinx Framebuffer driver and/or th=
e
>>>> Xilinx
>>>> 
>>>>        PLB TFT Controller IP block (plb_tft_cntlr_ref_v1_00_d) does
not
>>>> appear
>>>> 
>>>>        to centre the display on a VGA screen properly(vertically
>>>> offset).
>>>> 
>>>>   (iii) 64-bit write/read access to peripheral integrated onto the
>>>> Xilinx
>>>> 
>>>>         Virtex-II Pro FPGA either causes a system crash or only lowe=
r
>> part
>>>> 
>>>>         of 32-bit data to be written (i.e. lower part of 64-bit data=

>>>> appears
>>>>         to be mirrored on the upper and lower 32-bits of the system
>>>> bus).
>>>>         However, 32-bit write/read access to the peripheral passes a=
s
>> well
>>>>         as 64-bit write/read access to the SDRAM memory address spac=
e.
>>>>         Peripheral interface has been verified to be IBM PLB complia=
nt
>>>
>>>>         via IBM bus functional model simulations. 
>>>> 
>>>>    (iv) The Linux 2.6.26 Xilinx Framebuffer driver on the Xilinx XUP=
V2P
>>>> board
>>>> 
>>>>         does not appear to be working - nothing displayed to
>>>> screen/console
>>>> 
>>>>         not switching to framebuffer device on bootup. 
>>>> 
>>>>    Just wondering if anybody has seen these issues before and know h=
ow
>>>to
>>>>    resolve them?
>>>> 
>>>>    Any info. appreciated,
>>>>    Regards,
>>>>    Alan.
>>>> 
>>>>   
>>>> 
>>>> 
>>>> _______________________________________________
>>>> Linuxppc-embedded mailing list
>>>> Linuxppc-embedded@ozlabs.org
>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>> 
>>>> 
>>>
>>>-- 
>>>View this message in context:
>http://www.nabble.com/Linux-issues-on-Xilinx-XUPV2P-board-tp18262250p189=
95644.html
>>>Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>>
>>>_______________________________________________
>>>Linuxppc-embedded mailing list
>>>Linuxppc-embedded@ozlabs.org
>>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
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
nx-XUPV2P-board-tp18262250p18997255.html
>Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
