Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CFD08DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 15:45:26 +1000 (EST)
Subject: Re: Trace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?S=E9bastien?= CHRETIEN
	<sebastien.chretien@fr.thalesgroup.com>
In-Reply-To: <48BCCB6D.5040209@fr.thalesgroup.com>
References: <319b0ac50809010216jac3ae30r9260699abde6535@mail.gmail.com>
	<929D3CED81F34E43887A393170D66FB926B259@GBRSUN01MS002.eu.xerox.net>
	<319b0ac50809010525w7451ef92m5aaf6fd5f5a8958e@mail.gmail.com>
	<929D3CED81F34E43887A393170D66FB926B40F@GBRSUN01MS002.eu.xerox.net>
	<929D3CED81F34E43887A393170D66FB926B41A@GBRSUN01MS002.eu.xerox.net>
	<48BC195F.4070505@gmail.com> <1220314383.13010.62.camel@pasglop>
	<48BCCB6D.5040209@fr.thalesgroup.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 02 Sep 2008 15:45:14 +1000
Message-Id: <1220334314.13010.89.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>, "Jenkins,
	Clive" <Clive.Jenkins@xerox.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-02 at 07:13 +0200, Sébastien CHRETIEN wrote:
> My board has only a uart device on a FPGA. I don't use the serial layer 
> because it isn't documented in Linux Device Driver 3rd. Only the tty 
> layer is documented

You won't go very far in linux kernel dev. with using books like
that :-)

Look at other drivers in drivers/serial that should give you all the
information you need :-0

Cheers,
Ben.
