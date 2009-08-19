Return-Path: <thirumalai.p@datapatterns.co.in>
Received: from ns0.datapatterns.co.in (mx0.datapatterns.co.in [121.242.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7D32EB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 20:23:29 +1000 (EST)
Received: from itd210 (itd210.datapatterns [10.5.4.110]) (authenticated bits=0)
	by ns0.datapatterns.co.in (8.14.2/8.14.2) with ESMTP id n7JALRH3026427
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 15:51:27 +0530
Message-ID: <8248C24180F247B8A741CA5DEE646936@itd210>
From: "Thirumalai" <thirumalai.p@datapatterns.co.in>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Regarding 64-bit implementation of mtd driver
Date: Wed, 19 Aug 2009 15:48:17 +0530
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,
    In my custom board the flash memory was 64 bit data size means two 32 
bit flash chips are combined together to form as 64 bit bus width. Is there 
any patch to use the flash memory in mtd layer on the linux-2.6 kernel. 
Because on kernel there is no support for 64 bit read/write on the low leve 
cfi driver(command set 002).
Regards,
T. 


**************** CAUTION - Disclaimer *****************This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribution or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive for the recipient), please contact the sender by reply email and delete all copies of this message. Also, email is susceptible to data corruption, interception, tampering, unauthorized amendment and viruses. We only send and receive emails on the basis that we are not liable for any such corruption, interception, tampering, amendment or viruses or any consequence thereof. 
*********** End of Disclaimer ***********DataPatterns ITS Group**********
