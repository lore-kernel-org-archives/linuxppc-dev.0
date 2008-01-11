Return-Path: <SRS0=Qnq1=SB=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 15808DDFAC
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 17:15:18 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: ibm4xx_quiesce_eth?
Date: Fri, 11 Jan 2008 07:14:59 +0100
References: <47866614.3010203@pikatech.com>
	<20080110122427.59102355@zod.rchland.ibm.com>
In-Reply-To: <20080110122427.59102355@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801110715.00058.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 January 2008, Josh Boyer wrote:
> On Thu, 10 Jan 2008 13:38:12 -0500
>
> Sean MacLennan <smaclennan@pikatech.com> wrote:
> > What exactly does this function do?
> >
> >     /* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't
> >      * do this for us
> >      */
> >
> > On the taco, with the 440EP, it doesn't seem to make any difference if I
> > call this or not. Since I am using u-boot, is it not needed?
>
> There are firmwares that do not reset the EMAC and MAL before passing
> control to the client program (Linux in our case).  This can cause
> weird things to happen, like spurious interrupts or DMAs from the
> hardware overwriting kernel memory.  So we quiesce the hardware really
> early on those.
>
> I don't believe U-Boot has that problem.  If it does, it should be
> fixed :)

No, U-Boot doesn't have this problem.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
