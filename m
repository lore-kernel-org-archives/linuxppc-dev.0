Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ADC6BDDD08
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:19:24 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l1GGIf8x002110
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 11:18:41 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1GGJIYk544100
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 09:19:18 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1GGJIRV006856
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 09:19:18 -0700
Date: Fri, 16 Feb 2007 10:19:17 -0600
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/12]: sungem_phy: support bcm5461 phy, autoneg.
Message-ID: <20070216161917.GD923@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<20070216001857.GC923@austin.ibm.com>
	<20070216004325.GA8192@austin.ibm.com>
	<200702161546.31765.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702161546.31765.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 16, 2007 at 03:46:31PM +0100, Arnd Bergmann wrote:
> On Friday 16 February 2007 01:43, Linas Vepstas wrote:
> > Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
> > Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> 
> You only have the Signed-off-by information here and in the other
> patches, but no 'From:' line.
> 
> I assume that Jeff uses the git-applymbox tool to import
> mails, in which case the first line of the patch description
> should be 'From: Someone Else <someone@example.com>', unless you
> are the author of the patch yourself.

Ahh. OK. I was assuming it was the first signed-off-by that counted.

--linas
