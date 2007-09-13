Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0493CDDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 02:05:54 +1000 (EST)
Date: Thu, 13 Sep 2007 11:05:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 10/10] mpc82xx: Add pq2fads board support.
Message-ID: <20070913160539.GA32696@ld0162-tx32.am.freescale.net>
References: <20070905192924.GI32462@ld0162-tx32.am.freescale.net>
	<9BC5B02A-4E9D-42DD-90C3-F8C3382F2A96@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9BC5B02A-4E9D-42DD-90C3-F8C3382F2A96@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2007 at 01:39:58AM -0500, Kumar Gala wrote:
> >+	CS: chipselect {
> 
> We need to document this in booting-without-of.

OK.

> >+		PIC: interrupt-controller@10c00 {
> >+			#interrupt-cells = <2>;
> >+			interrupt-controller;
> >+			reg = <10c00 80>;
> >+			compatible = "fsl,mpc8280-pic", "fsl,pq2-pic";
> 
> this should also have a "fsl,cpm2-pic" or something of that form.   
> (exact same pic exists on 8560, 85xx+CPM)

OK...  I did it as pq2 rather than cpm2 because IIRC it wasn't described
under the CPM section of the manual, so I didn't know if 85xx CPM2 had
the same thing.

-Scott
