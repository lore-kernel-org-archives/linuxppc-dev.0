Return-Path: <shrisha.prasad@in.abb.com>
Received: from apisx02.abbasiapacific.com.sg (apisx02.abbasiapacific.com.sg
	[210.24.147.18]) by ozlabs.org (Postfix) with ESMTP id 06A9C685E8
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Oct 2005 15:33:28 +1000 (EST)
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Message-ID: <OF9C8A73CA.88B8C155-ON6525709F.001C451E-6525709F.001C3403@in.abb.com>
From: shrisha.prasad@in.abb.com
Date: Wed, 19 Oct 2005 10:39:43 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 001C33FE6525709F_="
Subject: Parameter RAM Conflict of SCC1 SPI & Ethernet 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 001C33FE6525709F_=
Content-Type: text/plain; charset="us-ascii"

Hi all,

The MPC862 UM Errata mentions that there is possiblity to solve 
ParameterRAM Conflict without a Microcode patch .
I am working on a SerialEEPROM SPI Driver for mpc862
 my driver needs to do is read the chip number from SPROM and calculate 
the MAC address 
The SPI  mpc8xx is interfaced to 9346 eeprom for this and I want to 
retrieve the MAC address 

The errata tells that no patch  required for relocation ,but using some 
trick you can avoid it

I am using the UBoot SPI Driver code for MPC8xx ,Do I need to modify the 
code in order to suit my requirements 

Since I am a newbie in kernel programming ,some help is requested .

Regards

--=_alternative 001C33FE6525709F_=
Content-Type: text/html; charset="us-ascii"


<br><font size=2 face="sans-serif">Hi all,</font>
<br>
<br><font size=2 face="sans-serif">The MPC862 UM Errata mentions that there is possiblity to solve ParameterRAM Conflict without a Microcode patch .</font>
<br><font size=2 face="sans-serif">I am working on a SerialEEPROM SPI Driver for mpc862</font>
<br><font size=2 face="sans-serif">&nbsp;my driver needs to do is read the chip number from SPROM and calculate the MAC address </font>
<br><font size=2 face="sans-serif">The SPI &nbsp;mpc8xx is interfaced to 9346 eeprom for this and I want to retrieve the MAC address </font>
<br>
<br><font size=2 face="sans-serif">The errata tells that no patch &nbsp;required for relocation ,but using some trick you can avoid it</font>
<br>
<br><font size=2 face="sans-serif">I am using the UBoot SPI Driver code for MPC8xx ,Do I need to modify the code in order to suit my requirements </font>
<br>
<br><font size=2 face="sans-serif">Since I am a newbie in kernel programming ,some help is requested .</font>
<br>
<br><font size=2 face="sans-serif">Regards</font>
<br>
--=_alternative 001C33FE6525709F_=--
