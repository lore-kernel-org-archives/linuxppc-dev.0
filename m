Return-Path: <dick@softplc.com>
Received: from ylpvm25.prodigy.net (ylpvm25-ext.prodigy.net [207.115.57.56])
	by ozlabs.org (Postfix) with ESMTP id 34E7E6865E
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2005 02:40:35 +1100 (EST)
Received: from [192.100.100.10] ([67.64.64.34])
	by ylpvm25.prodigy.net (smtpauth/dk/flock 8.13.4/8.13.4) with ESMTP id
	jA1FSeX2023895
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Nov 2005 10:28:40 -0500
Message-ID: <43678A3A.1050803@softplc.com>
Date: Tue, 01 Nov 2005 09:31:06 -0600
From: Dick Hollenbeck <dick@softplc.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: AMCC440EP Boot Source
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We are looking at the yosemite design but want a CF2 socket for the OS 
image.   Can U-Boot reside in the EEPROM accessible via I2C?  

This would allow us to remove the flash entirely in favor of the CF2 
flash.  If yes, are there any drawbacks to this vs. keeping a small bit 
of flash soldered to the board?


-- 
Please help fix the U.S. software industry before it is too late.
Contact your U.S. representatives with this information:
http://lpf.ai.mit.edu/Patents/industry-at-risk.html
http://www.groklaw.net/article.php?story=20041003041632172
