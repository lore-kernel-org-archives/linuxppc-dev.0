Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5320DDD0A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:27:02 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6HGQxad001101
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:26:59 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6HGQwGO257308
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 10:26:58 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6HGQwDn028271
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 10:26:58 -0600
Subject: Re: [PATCH] Add StorCenter DTS first draft.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 11:26:57 -0500
Message-Id: <1184689617.15570.1.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-17 at 16:57 +0200, Segher Boessenkool wrote:
> 
> > +	flash@ff800000 {
> > +		device_type = "rom";
> 
> I'm sure you know I find this "rom" binding to be crap.
> However, I didn't yet write up the "cfi" binding, so I
> can't complain ;-)

Not all chips are CFI compliant.  Be sure to write up the "jedec" and
"nand" bindings while you're at it ;)

josh
