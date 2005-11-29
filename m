Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 7BC586883C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 17:45:01 +1100 (EST)
Message-ID: <438BF854.1040408@compulab.co.il>
Date: Tue, 29 Nov 2005 08:42:28 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: SPI and USB on MPC8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi list,
I have a custom board based on MPC8272. I have a problem enabling the 
SPI and USB interfaces of the MPC8272 at the same time.
I'm running linux 2.6.12.3 with "custom" USB host driver. I tried to add 
the SPI driver present in denx linuxppc_2.4_devel git tree. When I 
enable the SPI driver first the USB host does not pass USB devices 
enumeration. When I enable the SPI driver after the USB, it hangs on 
while writing to CPCR.
Each driver works when used separately.
Does anybody have a clue why could it happen?
<http://source.denx.net/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git;a=summary> 


-- 
Sincerely yours,
Mike Rapoport
