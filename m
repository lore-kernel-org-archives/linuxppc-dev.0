Return-Path: <dwm@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 642C3679FB
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 05:08:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k34J8k8L002816
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 15:08:46 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k34J8kqj199040
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 15:08:46 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k34J8kJM031182
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 15:08:46 -0400
Message-Id: <200604041908.k34J8aqB022676@falcon10.austin.ibm.com>
In-reply-to: <20060404190211.GA26830@suse.de> 
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] powerpc: iSeries has only 256 IRQs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Apr 2006 14:08:36 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 04 Apr 2006 21:02:11 +0200, Olaf Hering wrote:
> On Tue, Apr 04, Doug Maxey wrote:
>
>> What firmware level?
>
>Of the card? No idea. At some point I had to upgrade it to make it

Both the card and the system level please.  Sorry if missed the info.

>usable with lpfc in SLES9 SP2. But right now I couldnt upgrade it, kind
>of chicken/egg problem. Driver has to be loaded to upgrade the firmware.
>I will try to put that card into another box to upgrade the firmware.
>
>I think the irq change itself is not the cause for the crash here.
>
