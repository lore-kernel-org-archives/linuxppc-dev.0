Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s22.bay0.hotmail.com (bay0-omc2-s22.bay0.hotmail.com
	[65.54.246.158]) by ozlabs.org (Postfix) with ESMTP id DF47967C0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 00:18:49 +1000 (EST)
Message-ID: <BAY110-F391AE6DCE84284F62F4FEAB2460@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: lombardo@mdivac.com
Subject: TEMAC problem on ML403 with U-boot.
Date: Tue, 22 Aug 2006 14:18:44 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Frank,
In your ML403 design which is booted by U-boot, do you use the normal 
10/100M Enet MAC or TEMAC? Is TEMAC supported by U-Boot 1.1.4? In my design 
I use TEMAC and it works well when I boot my Linux directly using Xilinx 
EDK bootloader. However it fails when using U-boot......

Thanks for your telling.

Regards
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
