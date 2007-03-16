Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 419C3DDECA
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 01:38:31 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: "Bart Van Assche" <bart.vanassche@gmail.com>
Subject: Re: +
	ocotea-board-ntpd-complains-that-the-frequency-error-exceeds-the-tolerance.patch
	added to -mm tree
Date: Fri, 16 Mar 2007 15:40:42 +0100
References: <200703161052.l2GAqIRV009441@shell0.pdx.osdl.net>
	<FD6A6842-530A-444B-A198-51947F3EAC20@kernel.crashing.org>
	<e2e108260703160734o24550c4dp7bef0d7f33bcdcc5@mail.gmail.com>
In-Reply-To: <e2e108260703160734o24550c4dp7bef0d7f33bcdcc5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703161540.44334.sr@denx.de>
Cc: "linuxppc-dev@ozlabs.org ML" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 March 2007 15:34, Bart Van Assche wrote:
> >   I asked Stefan & Josh to look at this and Stefan believes its a
> > 33.33Mhz clock.  So should this really be 33330000?
>
> I have measured the clock frequency on the two Ocotea boards I have on
> my desk, and both have a clock crystal of 33.3 MHz, not 33.33 MHz.
> What I don't know is whether the same clock crystal is mounted on all
> Ocotea boards.

Hmmm. From what I could read from the schematics, it should be 33.33MHz. But 
here is always a gray zone. I'll ask AMCC, what is equipped right now.

Thanks.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
=====================================================================
