Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 75D6DDE161
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 11:19:04 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0U0GqSq026830
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 19:16:52 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0U0IwXc197154
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 19:18:58 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0U0Iww8016748
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 19:18:58 -0500
Date: Thu, 29 Jan 2009 19:18:42 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Broken PCI on Sequoia
Message-ID: <20090130001842.GB3943@zod.rchland.ibm.com>
References: <alpine.LRH.2.00.0901291819440.22142@vixen.sonytel.be>
	<1233267061.18767.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1233267061.18767.5.camel@pasglop>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 30, 2009 at 09:11:01AM +1100, Benjamin Herrenschmidt wrote:
>On Thu, 2009-01-29 at 18:37 +0100, Geert Uytterhoeven wrote:
>> 	Hi Ben, Josh,
>
>
> .../...
>
>> Git-reverting this commit on top of 2.6.29-rc3 makes the crash go away.
>> 
>> Perhaps sequoia.dts (and other 44x DTS files) had to be changed, too?
>
>Weird, maybe I have a bug when there is no ISA hole in the DT, I'll have
>a look later today.

Yeah.  In fact, I think you have that bug in almost every board.  You only
updated Bamboo and Canyonlands with the initial patch and the changelog
says "other boards can be updated separately."  Nobody did that.  So not
so weird after all.

josh
