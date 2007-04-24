Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (uncle.computing.dundee.ac.uk
	[134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 514E3DE1C5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 23:55:28 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l3ODsu8L006766
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Apr 2007 14:54:56 +0100
Message-ID: <462E0C2F.2020106@computing.dundee.ac.uk>
Date: Tue, 24 Apr 2007 14:54:55 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: Using Xilinx Framebuffer on ML405 and 2.6.20.4
References: <462DCA31.4060009@computing.dundee.ac.uk>
	<528646bc0704240638m4c9dd04dlaaef0e8cdb57af53@mail.gmail.com>
	<462E0CF5.4060402@ru.mvista.com>
In-Reply-To: <462E0CF5.4060402@ru.mvista.com>
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

Andrei Konovalov wrote:
> Grant Likely wrote:
>> On 4/24/07, Peter Mendham <petermendham@computing.dundee.ac.uk> wrote:
>>> Dear all,
>>>
>>> I am wanting to use the Xilinx TFT controller from the ML403/5 
>>> reference
>>> project (probably from ML300 as well) under a 2.6.20.4 kernel.  I have
>>> Grant Likely's patchset applied in which there is a platform device
>>> entry for the framebuffer.  Does anyone know if there is mainline
>>> support for the Xilinx-style framebuffer?  If so, how do I enable 
>>> it?  I
>>> have included framebuffer support in my kernel build, but I assume I
>>> need a driver also? Any tips greatly appreciated.
>>
>> Heh, I've got a driver.  I just haven't published it yet.  Give me a 
>> few days...
>>
>> g.
>>
>
> We have one too :)
>
Do you have a patch that I can apply to a mainline kernel to include the 
driver?

Thanks,
-- Peter


-- 
------------------------------------------
Dr Peter Mendham
------------------------------------------
Space Systems Research Group
School of Computing, University of Dundee
Dundee, Scotland, DD1 1HN, UK
------------------------------------------
e: petermendham@computing.dundee.ac.uk
t: +44 (0)1382 386729
f: +44 (0)1382 388838
------------------------------------------


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
