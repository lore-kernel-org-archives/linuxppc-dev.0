Subject: Re: ibook2 first rev modem
From: Bastien Nocera <hadess@hadess.net>
To: =?ISO-8859-1?Q?F=E9lix?= Ortega <guile@mac.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1011233996.23635.42.camel@milleniumfalcon>
References: <1011200645.6549.23.camel@dozo>
	<1011233996.23635.42.camel@milleniumfalcon>
Date: 17 Jan 2002 03:30:35 +0000
Message-Id: <1011238236.6980.32.camel@dozo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2002-01-17 at 02:25, Félix Ortega wrote:
> On Wed, 2002-01-16 at 18:04, Bastien Nocera wrote:
> >
> > I've finally been able to get the iBook dual-USB's i2c modem to work and
> > dialup to my ISP.
> What was the problem? I'm using my ibook's modem since september without
> any issue....

Couldn't connect

> > The problem lies in the modem's firmware. If you haven't updated the
> > modem firmware, the modem won't be able to connect at v.90 for some
> > ISPs. (I verified by dialling up from MacOS X, it didn't work for v90,
> > but did for v34).
> >
> I have not updated my ibook's modem firmware and connect almost always
> at v90 with three distinct ISP's.

You're lucky.

> > PS: Here is the modem init line I use:
> > \d\d\d\d\d\d\dAT&FE0W1Q0V1X4&C1&K3S95=1&D3S7=75S0=0+MS=11,1,300,33600
> > I tried adding an M0 somewhere, but couldn't get the modem to shut up.
> > Any ideas ?
> Why you use such a string? I'm using ATM0 and everything works...

It's the init string MacOS X uses

> What was wrong whith your modem?

Couldn't connect to the isp, "HANGUP" just after link ttyS0 and ppp0
together.

Cheers

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
