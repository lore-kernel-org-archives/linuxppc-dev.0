Date: Wed, 19 Sep 2001 18:43:38 +0200
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Subject: Re: BitKeeper and linuxppc_2_4_devel
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Tom Rini <trini@mvista.com>, Matt Porter <mporter@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Message-id: <3BA8CB3A.4A8CB4B0@inn.ericsson.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <3BA86732.363312A4@imc-berlin.de>
 <20010919033824.B5042@cx258813-a.chnd1.az.home.com>
 <20010919074610.B17996@entropy.crashing.org> <3BA8B60C.E3FBFC24@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:
>
> > Er, there's a problem?  I didn't know you could do a clone from the
> > http one, just the bk:// version.  I'll try updating the bk version
> > running on source later this afternoon.
> >
> > bk://source.mvista.com/tree does work tho.
> > Did the http version ever work?
>
> Is it posible at all to use bk:// through a proxie server?
> If so, please tell me how. Which Port?
> The BitKeeper docs aren't exactly very detailed.
>
> Cheers,
>
> Steven

Well I never got it to work and since I never read anything from anyone that
it works assumed it just was not implemented.

But now I did some more testing and it turns out that bk when using http://
thru a firewall really do need the port number part of the http_proxy env
variable or else it won't work.



--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
