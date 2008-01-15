Return-Path: <yeduj@ece.pdx.edu>
Received: from ehlo.cat.pdx.edu (ehlo.cat.pdx.edu [131.252.208.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailhost.cecs.pdx.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 689E5DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 13:53:23 +1100 (EST)
Received: from pfeffer (pfeffer.cat.pdx.edu [131.252.208.114])
	by ehlo.cat.pdx.edu (8.13.5/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	m0F2dgD9019772
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 Jan 2008 18:39:42 -0800
Message-ID: <20080114183942.un31p1u02s4s8www@webmail.cecs.pdx.edu>
Date: Mon, 14 Jan 2008 18:39:42 -0800
From: Yedu Jathavedan <yeduj@ece.pdx.edu>
To: linuxppc-embedded@ozlabs.org
Subject: Using USB on ML403
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am a beginner to FPGA programming. I want to use the USB Host on  
ML403 in a PowerPC processor reference system to store some data on a  
Thumb Drive.

Currently, I've configured the BSP(OS support) as standalone. There is  
the OPB USB2 IP core with drivers which I want to use. But, not sure  
which port connections to use & if that will configure the Cypress  
CY7C67300 USB controller. The Application Note Xapp925 for ML403 uses  
OPB EPC core to configure the Cypress controller. If that is the case,  
is there any driver for the cypress controller?

If I use Linux kernel 2.6, how would it help me? Are there any drivers  
for the USB that I can use for kernel 2.6? If anyone has worked on  
this problem before, I would greatly appreciate their help.

Thanks & Regards,
Yedu Jathavedan
