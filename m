Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A4DBDDF13
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 09:25:25 +1100 (EST)
Message-ID: <47912763.8090106@freescale.com>
Date: Fri, 18 Jan 2008 16:25:39 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: A file of 5 MB on tmpfs file system uses 5 MB of RAM or more?
References: <F1F6EC0C8B75034F9E3A79FC85122E8EC8BBD1@aquib01a>
	<20080118155853.GA15620@ld0162-tx32.am.freescale.net>
	<F1F6EC0C8B75034F9E3A79FC85122E8E264A19@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E264A19@aquib01a>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

DI BACCO ANTONIO - technolabs wrote:
> No I simply did several malloc(s) without writing to the allocated space.
> 
> This means that the pages are not allocated really?

Correct.

-Scott
