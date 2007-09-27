Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id F1DEFDDD0D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 07:17:02 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 27 Sep 2007 23:17:00 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070927205012.GN7970@austin.ibm.com>
Message-ID: <20070927211700.201970@gmx.net>
MIME-Version: 1.0
References: <20070927191233.201980@gmx.net>
	<20070927192551.GK7970@austin.ibm.com> <20070927193131.201920@gmx.net>
	<20070927205012.GN7970@austin.ibm.com>
Subject: Re: 2.6.23-rc8 dies somewhere during boot!?
To: linas@austin.ibm.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Thu, 27 Sep 2007 15:50:12 -0500
> Von: linas@austin.ibm.com
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: 2.6.23-rc8 dies somewhere during boot!?

> On Thu, Sep 27, 2007 at 09:31:31PM +0200, Gerhard Pircher wrote:
> > 
> > > Betreff: Re: 2.6.23-rc8 dies somewhere during boot!?
> > > > 
> > > > I'm working on a 2.6.23 kernel for the AmigaOne.
> 
> Have you tried 2.6.22, or does that fail also?
> 
> --linas
No, not yet. The last kernel that is working on the AmigaOne is a 2.6.16.x
kernel (still arch/ppc). All further kernels (2.6.17 and 2.6.18) that I
compiled with the old platform code for arch/ppc showed a similar
behavior. I hoped that this would only be a side effect of the ppc ->
powerpc transition. I also tried to search through the changelog files
to find an indication for the problem.

Do you have an idea how to debug it?
I guess it would be possible with a JTAG debugger, but the AmigaOne is
a desktop system and I don't know, if the JTAG pins of the CPU are
accessible on the board.

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
