Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2FED67C10
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 10:06:47 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9506qvY000869
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Oct 2006 20:06:52 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9506gmD141252
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Oct 2006 20:06:42 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9506f4p006941
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Oct 2006 20:06:42 -0400
Date: Wed, 4 Oct 2006 19:06:41 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4]: Spidernet stop queue when queue is full
Message-ID: <20061005000641.GM4381@austin.ibm.com>
References: <20061003205240.GE4381@austin.ibm.com>
	<20061003205729.GF4381@austin.ibm.com>
	<200610040019.43028.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200610040019.43028.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 04, 2006 at 12:19:42AM +0200, Arnd Bergmann wrote:
> On Tuesday 03 October 2006 22:57, Linas Vepstas wrote:
> >                 result = NETDEV_TX_LOCKED;
> 
> Hmm, this looks a little strange to me. 

Right. This was left-over cruft from back when.

I'll fix this and resend the whole series tommorrow or friday, 
I've got a few more minor performnace tweaks, an implementation
of NETIF_F_SG, and another fix or two, etc.

--linas
