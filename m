Return-Path: <drfickle@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B304967B5D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 03:03:40 +1000 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6AGcBbu012649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 12:38:11 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6AGc5HK023869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 12:38:06 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6AGc5Gt236846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 12:38:05 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6AGc4rR006271
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 12:38:04 -0400
Subject: Re: Linux v2.6.18-rc1
From: Steve Fox <drfickle@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1152441242.4128.33.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<pan.2006.07.07.15.41.35.528827@us.ibm.com>
	<1152441242.4128.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 11:38:02 -0500
Message-Id: <1152549482.2658.29.camel@flooterbu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-07-09 at 20:34 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> > We've got a ppc64 machine that won't boot with this due to an IDE error.
> 
> What machine precisely ?

It's called bl5-6 in ABAT and lists itself as a 970 (8842-P1Z).

Also, booting with ide=nodma, as Alan suggested to Will, did not help.

> > [snip]
> > Freeing unused kernel memory: 256k freed
> >  running (1:2) /init autobench_args: ABAT:1152213829
> > 
> > creating device nodes .hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > 
> 
-- 

Steve Fox
IBM Linux Technology Center
