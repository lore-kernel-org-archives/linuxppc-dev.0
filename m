Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <007a01c44e69$bb7de860$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Matevz Langus" <matevz.langus@fortunal.net>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20040609154634.29212C109F@atlas.denx.de> <1086815570.3985.13.camel@n1020>
Subject: Re: JTAG debuggers for Motorola 8xx/82xx/85xx
Date: Wed, 9 Jun 2004 17:35:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For 8xx, the open source BDM4GDB (which you can get from www.denx.de) is
great.  I also partially ported the bdm driver to Windows for production
testing work.  Under Windows, I've used CrossView (from Tasking.com) with
Macraigor Wiggler (ocdemon.net) - all priced very reasonably.  However
CrossView does not support linux (but BDM4GDB does, of course)

Mark Chambers

>
> Which JTAG debugger do you suggest for Mot 8xx/82xx/85xx processors?
> If possible without stupid licensing model, where every time Motorola
> changes partnumber for the same chip new license and a couple k$ are
> needed.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
