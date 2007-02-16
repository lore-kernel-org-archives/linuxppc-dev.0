Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22877DDECE
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 11:19:04 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G0J0uK016459
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:19:00 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G0Ixfm291916
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:18:59 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G0Iwa8004861
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:18:59 -0500
Date: Thu, 15 Feb 2007 18:18:57 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCHSET] spidernet, sungem_phy: consolidated patch series
Message-ID: <20070216001857.GC923@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45D3EAA7.80805@garzik.org>
	<1171525923.20192.243.camel@localhost.localdomain>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<1171572392.5644.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171572392.5644.15.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Jeff Garzik <jeff@garzik.org>, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>,
	James K Lewis <jim@jklewis.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 16, 2007 at 07:46:32AM +1100, Benjamin Herrenschmidt wrote:
> 
> > I can send a tested patch series (merging all three sources)
> 
> Just send the blast to our list first so I can verify that the
> sungem_phy doesn't adversely affect sungem and everybody 

By "our list", I assume you mean "linuxppc-dev@ozlabs.org". 
I'm going to severely trim the cc list at this point, and 
send a patch series of 12 shortly.  I'm going to pretend
as if I was maintainer (formalities on this side pending)
and attach a "signed-off-by" to each.  Ben, it'll be up to 
you to go/no-go; if you say "go", I'll repost to eff Garzik
(right?)

> (especially Kou
> sine you dn't have the Toshiba hardware, do you ?) can verify it all
> works fine.

I don't have Toshiba hardware. FWIW, I also don't have a ps3. 

--linas
