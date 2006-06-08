Return-Path: <jianfei616@hotmail.com>
Message-ID: <BAY113-F70D5359537D7DC16B4678988B0@phx.gbl>
In-Reply-To: <912A1A11-36AB-4E68-BC29-7F584270C4F0@freescale.com>
From: "Guo Jaffe" <jianfei616@hotmail.com>
To: afleming@freescale.com
Subject: Re: does Gianfar Ethernet Controller Version 1.1 support MARVELL
	88E1111?
Date: Fri, 09 Jun 2006 01:51:59 +0800
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

Hi Andy,

Thank you for your information. So the driver is not the issue, but better 
to upgraded.

I will check the board once more. The PHY doesn't work because the 8bit bus 
between MAC and PHY is locked(TX_EN and RX_DV all disabled from the scope's 
view) and also you can't see any signals exist at the Magnetic side(nor LED 
signals). It seems that only MDC/MDIO and CLOCK reference pin works. The 
PHY's ID must be read from MDC/MDIO interface and Clocks are right showed 
on the scope.

Best Regards,
Jaffe


>From: Andy Fleming <afleming@freescale.com>
>To: 郁 剑非 <jianfei616@hotmail.com>
>CC: Linuxppc-embedded@ozlabs.org
>Subject: Re: does Gianfar Ethernet Controller Version 1.1 support MARVELL 
88E1111?
>Date: Thu, 8 Jun 2006 11:15:32 -0500
>
>
>On Jun 8, 2006, at 02:43, 郁 剑非 wrote:
>
>>Hi all,
>>I'm debugging my board with MPC 8540 and marvell 88e1111 designed  
>>on it.
>>I'm sure the hardware connection is correct, and the phy's ID could 
>>  be read
>>through terminal port. But anyway, phy can not work. I wonder if it 
>>  is the
>>driver's problem? Since the Gianfar Ethernet Controller Version 1.1
>>surpport 88e1011s, but some 88e1111's registers are different from
>>88e1011s'. Actually I'm a new guy to Linux. Has anybody ever used  
>>88e1111
>>phy in Linux envirenmemt? Please
>>give me some points. Thank you!
>>I have read the Gianfar ethernet controller driver, but it's  
>>difficult for
>>me to find out the sofware flow.
>
>
>It would be better if you upgraded to the latest kernel.  The PHY  
>subsystem in the driver has changed significantly since version 1.1  
>of the driver.  What leads you to believe that the PHY doesn't work? 
>   What errors do you see?  I'm fairly certain the 88e1111 works 
>with  the 88e1011 driver, but it's been a while.
>
