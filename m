Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 95A03DDDF4
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 19:29:04 +1100 (EST)
Date: Mon, 12 Mar 2007 09:28:59 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Norbert Eicker <n.eicker@fz-juelich.de>
Subject: Re: [PATCH] spidernet: Fix problem sending IP fragments
In-Reply-To: <200703100016.58469.n.eicker@fz-juelich.de>
Message-ID: <Pine.LNX.4.62.0703120927570.15144@pademelon.sonytel.be>
References: <20070308231556.GE30703@austin.ibm.com>
	<45F19103.3010100@pobox.com>
	<200703100016.58469.n.eicker@fz-juelich.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 10 Mar 2007, Norbert Eicker wrote:
> On Friday, 9. March 2007 17:53, Jeff Garzik wrote:
> > Linas Vepstas wrote:
> > > Please apply. The rather long patch description is from the submitter,
> > > Norbert Eicker, I don't know if that's alright, or if I should ask to
> > > have it trimmed.
> > >
> > > Thanks,
> > > --linas
> > >
> > > From: Norbert Eicker <n.eicker@fz-juelich.de>
> > >
> > >
> > > Signed-off-by: Norbert Eicker <n.eicker@fz-juelich.de>
> > > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> >
> > are you sure it can't send out fragmented IP frames?  what's really
> > going on here?
> 
> Pretty sure that fragmented IP frames are not send out. Here's a small test 
> using ttcp and tcpdump reproducing the problem (I assume a MTU of 1500):

Hence if I understand that correctly, NFS over UDP doesn't work at all as NFS
uses 8 KiB UDP packets by default?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
