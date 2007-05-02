Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E01E2DDEEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 19:05:23 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l42959GT029706
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 May 2007 10:05:09 +0100
Message-ID: <46385444.5060407@computing.dundee.ac.uk>
Date: Wed, 02 May 2007 10:05:08 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: Peter Korsgaard <peter.korsgaard@barco.com>
Subject: Re: Using Cypress EZ-Host on ML403/5
References: <4623A197.6000104@computing.dundee.ac.uk>	<528646bc0704160932k2038090al8c0b8e5420422545@mail.gmail.com>
	<87zm54mt3j.fsf@sleipner.barco.com>
In-Reply-To: <87zm54mt3j.fsf@sleipner.barco.com>
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

Peter Korsgaard wrote:
>>> Has anyone had the Cypress EZ-Host chip working as a USB host under
>>> Linux?  It's the one that comes fitted as standard to ML403 and
>>> ML405 boards (probably other Xilinx boards too).  If not, can
>>> anyone tell me where I should start?  Any advice at all?  Our own
>>> embedded device needs to have USB host support and we are using an
>>> ML40x for development so the EZ-Host is the preferred solution as
>>> we can prototype it.
>>>       
> Grant> It's on my task list to get working.  I could certainly use
> Grant> some help.
>
> I have written a 2.6 USB host driver for the Cypress
> EZ-Host/EZ-Otg. It's basically working, but needs a bit more
> cleanup. I hope to be able to submit it next week.
>   
Peter,

Are you any further forward with this?  Is there anything I could see 
(however pre-release)?  Is there anything I can do to help?

Many thanks,
-- Peter


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
