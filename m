Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBA87DDEC4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 19:12:30 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l3O9CGdi014208
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Apr 2007 10:12:16 +0100
Message-ID: <462DCA31.4060009@computing.dundee.ac.uk>
Date: Tue, 24 Apr 2007 10:13:21 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Using Xilinx Framebuffer on ML405 and 2.6.20.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,

I am wanting to use the Xilinx TFT controller from the ML403/5 reference 
project (probably from ML300 as well) under a 2.6.20.4 kernel.  I have 
Grant Likely's patchset applied in which there is a platform device 
entry for the framebuffer.  Does anyone know if there is mainline 
support for the Xilinx-style framebuffer?  If so, how do I enable it?  I 
have included framebuffer support in my kernel build, but I assume I 
need a driver also? Any tips greatly appreciated.

Thanks in advance,
-- Peter


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
