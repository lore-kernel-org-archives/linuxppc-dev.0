Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89786DDF30
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 23:46:38 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l3ODkJUF006002
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Apr 2007 14:46:19 +0100
Message-ID: <462E0A29.5080601@computing.dundee.ac.uk>
Date: Tue, 24 Apr 2007 14:46:17 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Using Xilinx Framebuffer on ML405 and 2.6.20.4
References: <462DCA31.4060009@computing.dundee.ac.uk>
	<528646bc0704240638m4c9dd04dlaaef0e8cdb57af53@mail.gmail.com>
In-Reply-To: <528646bc0704240638m4c9dd04dlaaef0e8cdb57af53@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Grant Likely wrote:
> Heh, I've got a driver.  I just haven't published it yet.  Give me a 
> few days...
Fantastic.  I'm happy to be on the front line of alpha testing if that's 
any help.

No worries with a few day's delay though, I'm trying to fit the TFT 
controller into with my design with a TEMAC in it and I'm having some 
serious issues meeting timing requirements.  The SystemACE controller 
just gives up the ghost loading the kernel image.  If you or anyone else 
has any tips on how to get designs that fail timing to work I'd love to 
hear them.  The other thing is a sanity check: I've assumed the reason 
the SystemACE controller is giving up is a bus mess-up caused by 
timing.  Any better ideas?

-- Peter

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
