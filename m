Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 6648267B59
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 23:51:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 11 Apr 2005 08:51:53 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859354@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Stefan Nickl" <Stefan.Nickl@kontron.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] RE: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Stefan Nickl [mailto:Stefan.Nickl@kontron.com]=20
> Sent: Monday, April 11, 2005 04:20
> On Fri, 2005-04-08 at 09:39 -0500, Rune Torgersen wrote:
> > I'm not sure what is going on, but that patch causes me to=20
> get "eth0: tx
> > queue full!." messages as soon as I try to use the ethernet
> > (Same thing happened if I just tried to remove the fcc_restart from
> > init_fcc_startup)
> But regarding my current indisposition with hardware, I'd suggest to
> choose the smaller of the two evils, that is calling fcc_restart()
> before starting the queue, leaving but a tiny race condition=20
> on rx side.

Still get the tx full messages.
They do go away if I call fcc_restart twice in a row... (again)=09
I'll look a little more on what it is doing
