Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDAB6B6F59
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  2 May 2011 23:42:55 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Read/write BCSR registers of PPC460EX
Date: Mon, 2 May 2011 15:42:45 +0200
References: <31522823.post@talk.nabble.com> <201105021453.32775.sr@denx.de>
	<31523658.post@talk.nabble.com>
In-Reply-To: <31523658.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201105021542.45367.sr@denx.de>
Cc: linuxppc-dev <eftakhar.chowdhury@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Efti,

On Monday 02 May 2011 15:36:15 linuxppc-dev wrote:
> Dear Stefan,
> 
> I have changed CPLD/BCSR address with 0x4E1000000.
> 
> static unsigned long mem_addr =  0x4E1000000;

Thats a 64bit address, so you need this:

static unsigned long long mem_addr =  0x4E1000000ULL;

You should have seen a compilation warning about this too.
 
Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
