From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Matt Porter" <mporter@mvista.com>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MVME5100: kernel hangs in dcache_init
Date: Fri, 16 Feb 2001 16:37:42 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMEEOECOAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010216044002.B8737@cx258813-a.chnd1.az.home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Did you make sure it's getting the correct memory size?

I think the problem is not there because the printks before the hang shows
the correct value (I have inserted the printouts of my boot process at the
bottom of the message)

>  Assuming you're
> trying to port into the existing prep_* framework, it does use residual
> data to determine memory size.  That used to be reasonable but the
> newer MCG boards are not providing any useful information in
> residual data, I'd imagine this is also the case with the 5100.  That's
> why the new MCG ports in the development tree no longer rely on residual
> data.

Yes, I'm working on prep_* framework, but the residual seems significant and
correct (to my un-expert eyes :-)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
