Return-Path: <dvdstar@hotmail.com>
Received: from hotmail.com (bay24-f40.bay24.hotmail.com [64.4.18.90])
	by ozlabs.org (Postfix) with ESMTP id B86E2679F0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 11:07:06 +1000 (EST)
Message-ID: <BAY24-F40F8F31EEE582D1E998CFEAD030@phx.gbl>
From: "tuotuo wang" <dvdstar@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 30 May 2005 01:07:05 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Subject: FW: Re: load u-boot.bin failure with BDI2000
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>From: Shawn Jin <shawnxjin@gmail.com>
>Reply-To: Shawn Jin <shawnxjin@gmail.com>
>To: tuotuo wang <dvdstar@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: load u-boot.bin failure with BDI2000
>Date: Sun, 29 May 2005 11:28:28 -0700
>
> > My target board is SBC8260,my debugger BDI2000,i have complied my 
u-boot
> > file .But here is a mistake when i load it.Now i cann't enter the 
command
> > line of u-boot.here is the display of BDI2000:
> > - TARGET: processing user reset request
> > - TARGET: Target PVR is 0x00810101
> > - TARGET: reseting target passed
> > - TARGET: processing target init list ....
> > *** TARGET: processing target init list failed
> > # PPC: Writing to workspace failed
>
>There is somehting wrong with BDI2000 configuration file. Double check
>what [INIT] section does for your target board.
>
>-Shawn.


You know,my config file of BDI2000 is download from www.denx.de,because 
there have the sbc8260's.My board run the ppcboot at first,and i can use my 
BDI2000 properly with this config file.

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
