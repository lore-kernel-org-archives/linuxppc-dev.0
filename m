Return-Path: <maz@misterjones.org>
Received: from young-lust.wild-wind.fr.eu.org (lopsy-lu.misterjones.org
	[62.4.18.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFB0B6865E
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 04:52:16 +1000 (EST)
From: Marc Zyngier <maz@misterjones.org>
To: Mark Guertin <mguertin@macdiscussion.com>
In-Reply-To: <6337E791-EB1F-47E5-8518-FE0D83987705@macdiscussion.com> (Mark
	Guertin's message of "Fri, 21 Oct 2005 14:36:02 -0400")
References: <wrpll0of535.fsf@wild-wind.fr.eu.org>
	<1129869509.6265.32.camel@gaston>
	<wrpek6eeo94.fsf@wild-wind.fr.eu.org>
	<6337E791-EB1F-47E5-8518-FE0D83987705@macdiscussion.com>
Date: Fri, 21 Oct 2005 20:52:09 +0200
Message-ID: <wrp3bmuln3a.fsf@wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: Re: v2.6.13.4 : Bad page state at prep_new_page when booting with
	quik
Reply-To: maz@misterjones.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Mark" == Mark Guertin <mguertin@macdiscussion.com> writes:

Mark> Not sure what quick version you are using, but the guys at  
Mark> shiner.info have been hacking on it for a while (including some bug  
Mark> fixes) .. so you might want to try out alternate versions if you  
Mark> haven't already.

Mark> http://shiner.info/?files/Yellow%20Dog%20Linux%204/quik

Hmmm, checking...

maz@strange-fruit:~$ dpkg -l quik
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  quik           2.1-6          Bootloader for PowerMac or CHRP systems

Looks like I already have the latest...

Thanks anyway.

	M.
-- 
And if you don't know where you're going, any road will take you there...
