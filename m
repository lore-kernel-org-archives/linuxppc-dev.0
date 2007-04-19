Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7ABB8DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 01:47:47 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l3JFlRbw030950
	for <linuxppc-embedded@ozlabs.org>; Thu, 19 Apr 2007 16:47:28 +0100
Message-ID: <46278F3A.4070007@computing.dundee.ac.uk>
Date: Thu, 19 Apr 2007 16:48:10 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: Tri-mode auto-negotiation on ML405
References: <461F65E3.1050004@computing.dundee.ac.uk>
	<461FAF0D.3070803@ru.mvista.com>
In-Reply-To: <461FAF0D.3070803@ru.mvista.com>
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
> And I've tried the PHY library (drivers/net/phy/*) introduced by Andy 
> Fleming.
> Kinda works. [...]
> Attached is the incomplete adapter.c (with FIFO mode support only) which
> uses the PHY lib to handle the PHY. Just to illustrate the idea (will 
> post the
> patch later when it is completed).
Hi Andrei,

I've now had a chance to have a go at the adapter.c you sent properly 
(sorry about the delay).  I'm afraid I can't get it to work.  I was 
wondering if you could tell me what I'm doing wrong.  When I try and 
bring the interface up I get:
SIOCSIFADDR: No such device
SIOCSIFNETMASK: No such device
SIOCSIFBRDADDR: No such device
SIOCGIFFLAGS: No such device
route: SIOC[ADD|DEL]RT: No such device

I have included PHYLIB and even tried including support for the Marvell 
PHY.  I still get the same. I'm sure I've made a stupid mistake, any ideas?

Thanks,
-- Peter



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
