Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.182.164]) by ozlabs.org (Postfix) with ESMTP id AEED667A7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 05:50:11 +1100 (EST)
Message-ID: <004801c52410$4247b700$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Rune Torgersen" <runet@innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B8592E9@ismail.innsys.innovsys.com>
Date: Tue, 8 Mar 2005 13:54:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>Now I can almost boot....:
>It craches when trying to read from harddisk
>(only happens with more than 512MB)


Don't rule out a hardware problem, namely addressing to SDRAM.  It could be
consistent with what you're seeing - when you start to load a lot of data
and
cross some address you step on older data (or code).

--Mark C.

> > Anybody know how to get more than 512MB (1-2GB) of RAM to work with
> >  2.6.11 on a 8265?
> >
> > Weird stuff and crashes keep happening on kernel start
> (vmalloc out of
> > memory, and a pci driver ups) when I tell the kernel I have
> more than
> >  512MB of ram.
> > The pci craches happens when I tell the kernel I have 740-760MB or
> > more.
> >
> > Any idea of where to start to look for this?
> >
