Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 47428DDF45
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 20:07:31 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PPC4xx ECC Configs, Defines and Source
Date: Wed, 10 Dec 2008 10:07:16 +0100
References: <C562B54F.1351E%gerickson@nuovations.com>
	<20081208202152.GA10929@yoda.jdub.homelinux.org>
	<1228899216.22413.52.camel@pasglop>
In-Reply-To: <1228899216.22413.52.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200812101007.16677.sr@denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 10 December 2008, Benjamin Herrenschmidt wrote:
> > Why is there a need to have so many files?  I would think you could
> > have a single file with all the ECC monitoring implementations in it
> > called ppc4xx_ecc.c (or such).  Surely they would share some amount
> > of code?
>
> Well, it depends how much they share, but I'd rather have separate files
> with helpers in ppc4xx_soc.c if it's small, that way, it's easier to
> only build selected files based on what SoC support is enabled.

ACK. The Denali core for example from 440EPx/GRx is completely different. 
Trying to fit this Denali ECC handling into the IBM-DDR(2) code would result 
in an ugly mess.

Best regards,
Stefan
