Return-Path: <jianfei616@hotmail.com>
Message-ID: <BAY113-F48AF982B29842D6A8C85598880@phx.gbl>
In-Reply-To: <15BDF877-21B2-40BD-A5F6-9CD83E5BB2CE@freescale.com>
From: "Guo Jaffe" <jianfei616@hotmail.com>
To: afleming@freescale.com, DaveLiu@freescale.com
Subject: Re: does Gianfar Ethernet Controller Version 1.1 support MARVELL
	88E1111?
Date: Fri, 09 Jun 2006 22:56:25 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




>From: Andy Fleming <afleming@freescale.com>
>To: Guo Jaffe <jianfei616@hotmail.com>
>CC: Linuxppc-embedded@ozlabs.org
>Subject: Re: does Gianfar Ethernet Controller Version 1.1 support MARVELL 
88E1111?
>Date: Thu, 8 Jun 2006 14:25:44 -0500
>
>
>On Jun 8, 2006, at 12:51, Guo Jaffe wrote:
>
>>Hi Andy,
>>
>>Thank you for your information. So the driver is not the issue, but 
>>  better to upgraded.
>>
>>I will check the board once more. The PHY doesn't work because the  
>>8bit bus between MAC and PHY is locked(TX_EN and RX_DV all disabled 
>>  from the scope's view) and also you can't see any signals exist 
>>at  the Magnetic side(nor LED signals). It seems that only MDC/MDIO 
>>and  CLOCK reference pin works. The PHY's ID must be read from 
>>MDC/MDIO  interface and Clocks are right showed on the scope.
>
>
>But what error are you getting?  What are the symptoms of your  
>problem?  The GMII interface (the 8-bit bus) is inconsequential to  
>PHY configuration and management.  Only the MDC/MDIO bus is used.   
>Therefore the PHY id should be quite readable.  What version of 
>Linux  are you using?  Please describe what the kernel prints out 
>when you  boot, and when you try to bring up the interface (assuming 
>you don't  do that at boot).
>
>Andy
