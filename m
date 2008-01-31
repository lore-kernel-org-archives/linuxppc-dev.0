Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 299E8DDF51
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 07:55:15 +1100 (EST)
Message-ID: <47A235AD.9050107@freescale.com>
Date: Thu, 31 Jan 2008 14:55:09 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: Kernel oops while duming user core.
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
	<20080131201601.GA10501@loki.buserror.net>
	<20080131204158.GV14201@localdomain>
In-Reply-To: <20080131204158.GV14201@localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> I doubt the modules are the problem; there was a practically identical
> report from someone with an untainted 2.6.24-rc kernel a few weeks ago
> (see my first reply to Rune).

I didn't think they were; I was just trying to eliminate the low hanging 
fruit and get a simpler testcase. :-)

>> Do you have a simple test case that we could try to reproduce?  I tried a
>> simple core dump on an 8280, and it worked.
> 
> Is the crashing program multithreaded?  The first report had firefox
> triggering the oops.

OK, I've got a test program that triggers it now.  I'll see if I can 
figure out what's going on.

-Scott
