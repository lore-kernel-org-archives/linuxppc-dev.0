Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 5C0C3DDE28
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 03:01:21 +1000 (EST)
Message-ID: <49E8B69A.8010005@embeddedarm.com>
Date: Fri, 17 Apr 2009 10:04:26 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Grant Likely <grant.likely@secretlab.ca>
Subject: Example dts file 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I'm working on creating a dts file for a custom board based on the Yosemite AMCC 
440EP evaluation board. We have an FPGA connected to the PCI bus, and I'm a bit 
unsure how to describe this in the dts file. The FPGA implements an SD card 
core, RTC core, Nand core... Can anyone point me to an example dts file I can 
refer to?

I've read that I'm not required to describe every PCI device in the system. 
Although I'd like to eventually submit our changes for upstream support, so as 
far as I know I do need to specify all of these devices in the dts file, so 
drivers can parse the dts file to know what devices are present.

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive 	     | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com
