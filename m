Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB18BB6EFF
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2011 22:53:41 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Read/write BCSR registers of PPC460EX
Date: Mon, 2 May 2011 14:53:32 +0200
References: <31522823.post@talk.nabble.com>
	<20110502124039.GB3269@zod.rchland.ibm.com>
In-Reply-To: <20110502124039.GB3269@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201105021453.32775.sr@denx.de>
Cc: linuxppc-dev <eftakhar.chowdhury@yahoo.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 02 May 2011 14:40:39 Josh Boyer wrote:
> >static unsigned long mem_addr = 0xC0000000;// IP base address
> 
> Is this the correct address for the BCSR?  On the 460EX Canyonlands
> board, the CPLD/BCSR is at 0xE1000000.

To be precise: It's 0x4.e100.0000 as 36bit physical address.
 
Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
