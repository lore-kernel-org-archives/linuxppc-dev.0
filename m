Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 30B3267E43
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 10:16:24 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so295893wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 03 Aug 2005 17:16:23 -0700 (PDT)
Message-ID: <9b7ca6570508031716786e73b0@mail.gmail.com>
Date: Thu, 4 Aug 2005 09:16:23 +0900
From: Daniel Ann <ktdann@gmail.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20050803183932.GA13789@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca6570508022240715ae9cb@mail.gmail.com>
	<61C27372-4ADB-4E3A-8E20-9E811EE61B99@freescale.com>
	<9b7ca65705080223401a9ce913@mail.gmail.com>
	<20050803183932.GA13789@mag.az.mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8245 reboot
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark,

Guess I'll have to walk the uncharted area again :P
Thanks anyway tho. I'll start by looking at what that port 92
mechanism is first, and see where in our hw designer have put that in.

On 8/4/05, Mark A. Greer <mgreer@mvista.com> wrote:
> On Wed, Aug 03, 2005 at 03:40:18PM +0900, Daniel Ann wrote:
> > Absolutely not. Very much like sandpoint except, we dont use SIO at all=
.
> > FYI, most of sandpoint code from the kernel is function the board very
> > well at the moment. Only big issue lies with REBOOT at this stage:(
>=20
> Daniel,
>=20
> IIRC, the sandpoint uses the PC style port 92 mechanism to reset the boar=
d.
> You need to look at your hardware docs to see how your board can be reset=
.
> Don't expect the sandpoint reset code to work for you.
>=20
> Mark
>=20


--=20
Daniel
