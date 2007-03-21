Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 981B2DDF95
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 00:40:03 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2LDe0Fu015003
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Mar 2007 09:40:00 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2LDe0vA034918
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Mar 2007 07:40:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2LDe08q026876
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Mar 2007 07:40:00 -0600
Subject: Re: [PATCH] PPC440EPx/440GRx Sequoia/Rainier board support.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200703211426.55297.sr@denx.de>
References: <460034D0.5030503@ru.mvista.com> <200703211426.55297.sr@denx.de>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 08:39:50 -0500
Message-Id: <1174484390.3416.40.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-21 at 14:26 +0100, Stefan Roese wrote:
> On Tuesday 20 March 2007 20:24, Valentine Barshak wrote:
> > Add AMCC PPC440EPx/440GRx Sequoia/Rainier board support.
> >
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> Might I kindly ask you to include at least my Signed-off-by line before yours, 
> since this code seems to be nearly a 1:1 copy from our implementation. 
> Thanks.

I was going to ask about that.  This seems identical to what's been in
the denx tree for a while.  If it came from there, it needs Stefan's
sign off.

josh
