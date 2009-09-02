Return-Path: <eddie@embeddedarm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 83DDCB7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 09:52:40 +1000 (EST)
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 79533DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 09:52:39 +1000 (EST)
Message-ID: <4A9F0377.1070606@embeddedarm.com>
Date: Wed, 02 Sep 2009 16:44:55 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Grant Likely <grant.likely@secretlab.ca>
Subject: PPC PCI bus registers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I have a question regarding reading PCI bus registers from a user space 
application running on a PPC SBC. Seeing as though the PCI bus is little endian 
and PPC is big endian is it typical that one must perform a byte swap on all 16 
and 32 bit register reads?

I've found this is true on a custom board I am working on(with an FPGA connected 
via the PCI bus) and as a result I've added a byte swap command in busybox to 
accommodate this feature...

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive              | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com
