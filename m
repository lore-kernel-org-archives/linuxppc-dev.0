Message-ID: <018701c24db3$e053d3b0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Dan Malek" <dan@embeddededge.com>,
	"Kenneth Johansson" <kenneth.johansson@etx.ericsson.se>
Cc: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>,
	"Marius Groeger" <mag@sysgo.de>,
	"John Fisher" <John.Fisher@nec.com.au>,
	"Linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <000501c24979$6348a190$37d34c93@neca.nec.com.au>	<3.0.3.32.20020822173918.006dbb00@hollabaugh.com> 	<3D65C5A8.5010408@embeddededge.com> <1030095276.2481.230.camel@spawn> <3D66CF18.5040801@embeddededge.com>
Subject: Re: cygwin and embedded linux
Date: Tue, 27 Aug 2002 19:24:00 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I built a toolchain for ppc under cygwin about a year ago.
I used the Billgatliff's script(http://crossgcc.billgatliff.com/build-crossgcc.sh)
It failed to build glibc. So I copied glibc from a linux machine.
I've been using the toolchain, without any problem, for our custom MPC755 board, for about a year.
I recommand the Billgatliff's script, if you are going to make a tool chain for ppc under cygwin.

- Sangmoon Kim -

----- Original Message -----
From: "Dan Malek" <dan@embeddededge.com>
To: "Kenneth Johansson" <kenneth.johansson@etx.ericsson.se>
Cc: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>; "Marius Groeger" <mag@sysgo.de>; "John Fisher" <John.Fisher@nec.com.au>; "Linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Saturday, August 24, 2002 9:11 AM
Subject: Re: cygwin and embedded linux


>
> Kenneth Johansson wrote:
>
> > And I remember what you thought about people like me that tried to make
> > the cross compile environment going.
>
> The only opinion I have changed is that people that can actually make
> this work well (and I know of only a couple) have a special talent
> and I really like them to hang around :-)
>
> I guess when you work for a large company that will pay your salary regardless
> of missing schedules and can only provide half-assed tools you have to
> cobble together to make things work, you are both lucky and have my sympathy.
> I don't have the patience or development time to create or debug my
> development tools, they just have to work.  I'm not using anything that
> anyone else can't go out and purchase or download, and it continues to
> baffle me why people won't take the easy route to developing software.
>
>
> > But it finally did work out OK and nowadays all you really need to now
> > is what parameters to give the configure script.
>
> There is LOTS more to creating an easy to use and properly created set
> of development tools than knowing some parameters to configure scripts.
> Only a couple of people I know understand the magic, and it isn't documented.
> I'm just going to rely on them to make my job easier :-)
>
> Have fun!
>
>
> -- Dan
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
