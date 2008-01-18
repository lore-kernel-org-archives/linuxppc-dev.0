Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B917DDF7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 02:59:04 +1100 (EST)
Date: Fri, 18 Jan 2008 09:58:53 -0600
From: Scott Wood <scottwood@freescale.com>
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: A file of 5 MB on tmpfs file system uses 5 MB of RAM or more?
Message-ID: <20080118155853.GA15620@ld0162-tx32.am.freescale.net>
References: <F1F6EC0C8B75034F9E3A79FC85122E8EC8BBD1@aquib01a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EC8BBD1@aquib01a>
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

On Fri, Jan 18, 2008 at 02:15:02PM +0100, DI BACCO ANTONIO - technolabs wrote:
> I have a linux-2.6.19.2 board with an MPC880 with 16MB ram and 16 MB
> flash. 
> Normally I have 9-10 MB of free RAM.
>  
> If I allocate 5 MB of ram memory, the system continues to work normally,

Are you sure the RAM was actually allocated (i.e. did you write to all of
the pages)?

-Scott
