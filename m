Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 717A5DDEF6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 00:41:00 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l3OEeIeQ011311
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Apr 2007 15:40:18 +0100
Message-ID: <462E1713.5010806@computing.dundee.ac.uk>
Date: Tue, 24 Apr 2007 15:41:23 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [PATCH] Xilinx framebuffer device driver
References: <462E0D5C.1090105@ru.mvista.com>
In-Reply-To: <462E0D5C.1090105@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Rick Moleres <rick.moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:
> Add support for the video controller IP block included into Xilinx 
> ML300 and
> ML403 reference designs.
>
> Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
> ---
>
> This patch relies on the "Patchset to establish sanity in Xilinx 
> Virtex support" by Gran Likely to have
> the frame buffer device registered on the platform bus. Without this 
> patchset one needs to fill in
> the struct platform_device and make sure platform_device_register() is 
> called elsewhere.
>
> Reviews and comments are welcome.
Thanks, that's great.  I've built it into my latest kernel and as soon 
as I can get the hardware to work I'll test it out.  Watch this space :)
-- Peter


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
