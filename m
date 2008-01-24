Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00F40DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 12:23:17 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0O1NElO021496
	for <linuxppc-embedded@ozlabs.org>; Wed, 23 Jan 2008 20:23:14 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0O1NE5k255266
	for <linuxppc-embedded@ozlabs.org>; Wed, 23 Jan 2008 20:23:14 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0O1NE8X026477
	for <linuxppc-embedded@ozlabs.org>; Wed, 23 Jan 2008 20:23:14 -0500
Date: Wed, 23 Jan 2008 19:20:03 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Leonid" <Leonid@a-k-a.net>
Subject: Re: USB device for ppc440epx
Message-ID: <20080123192003.03f4fa0b@zod.rchland.ibm.com>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C02CEE287@ehost011-3.exch011.intermedia.net>
References: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl>
	<440abda90801202354l5a0ce4caq382af5991e36f775@mail.gmail.com>
	<BAY115-W344A18C61627B3075C6281B23D0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A5952@XMBIL132.northgrum.com>
	<BAY115-W415137ADEA0BE4A33D2BAEB23F0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A5959@XMBIL132.northgrum.com>
	<BAY115-W393608FBCB3E1070428538B23F0@phx.gbl>
	<20080123193557.AF0C8670018@mail194-sin.bigfish.com>
	<406A31B117F2734987636D6CCC93EE3C02CEE287@ehost011-3.exch011.intermedia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 23 Jan 2008 17:01:02 -0800
"Leonid" <Leonid@a-k-a.net> wrote:

> Hi:
> 
> does somebody have code example for USB 2.0 device implementation for
> ppc440epx, preferably Mass Storage device, but any will do.
> 
> If not for ppc440epx (Sequoia board), ppc440ep (Yosemite) code will also
> help (according to CPU user manual USB device interface is practically
> the same).
> 
> If this is already present in Linux kernel tree (from what version?),
> where it is located? 

USB mass storage works on 440EP already.  It'll be in 2.6.25 in
arch/powerpc.  I would suspect 440EPx works as well.

BTW, it's considered impolite to hijack a thread to ask a completely
unrelated question.

josh
