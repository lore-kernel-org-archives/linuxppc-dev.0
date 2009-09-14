Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 94DA1B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 22:51:37 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8ECopxA002663
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2009 08:50:51 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8ECpXRQ200398
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2009 08:51:33 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8ECpWqA007661
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2009 08:51:33 -0400
Date: Mon, 14 Sep 2009 08:51:29 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Ludo Van Put <ludo.vanput@gmail.com>
Subject: Re: Oops in IDE probing on ppc_440 when PCI is enabled in strapping
Message-ID: <20090914125129.GB12372@zod.rchland.ibm.com>
References: <5edaeed70909140536s53fb36ael4f0cb90abfe327e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5edaeed70909140536s53fb36ael4f0cb90abfe327e0@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2009 at 02:36:15PM +0200, Ludo Van Put wrote:
>Hi,
>
>we're working with a PPC440GX on a board that has a.o. a compact flash slot.
>We had the PCI subsystem of the ppc disabled in strapping for quite a while,
>until we wanted to start using it.
>However, when we enabled PCI in the strapping and in the (patched 2.6.10)

2.6.10?  Really?  If that is truly the case, you probably aren't going to get
a whole lot of help from the list, since that kernel is pretty ancient.

>kernel configuration, we triggered an oops when probing for IDE devices (to
>read out the first 512 bytes of the CF). I can see that the ioremap64 call
>in the driver code for our CF returns a different address (compared to PCI
>disabled in strapping), but using this address later on for accessing the CF
>goes wrong.

Posting the oops output would perhaps help.  Or maybe not.

josh
