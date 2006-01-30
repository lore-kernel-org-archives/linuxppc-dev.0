Return-Path: <allanjos@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.194])
	by ozlabs.org (Postfix) with ESMTP id D856868A02
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 06:30:35 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so1098419nzd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jan 2006 11:30:34 -0800 (PST)
Message-ID: <7a2435710601301130x18fc38b0o3b6bcbbe2a049ce2@mail.gmail.com>
Date: Mon, 30 Jan 2006 15:30:33 -0400
From: Moloko Vellocet <allanjos@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 - Problem with PSC mode
In-Reply-To: <7492B3D3325B424399725C8A03926A3E2592C2@osiemail.osii.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7492B3D3325B424399725C8A03926A3E2592C2@osiemail.osii.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you.

But the error persists, I can't get data stored in RX pin and write
data to TX pin.

Registers like 'rfnum' are with value '0' (zero).

I think that RX and TX has not been enabled.


On 1/30/06, Zeitler, Nathan <nzeitler@osii.com> wrote:
> Hi Allann,
>
> > out_8(&psc->command, MPC5xxx_PSC_RST_RX |
> >          MPC5xxx_PSC_RST_TX |
> >          MPC5xxx_PSC_SEL_MODE_REG_1 |
> >          MPC5xxx_PSC_RST_ERR_STAT);
>
> It looks like you're trying to do too many things at once here.
> ORing SEL_MODE_REG_1 and RST_ERR_STAT together
> forms a completely different command in the Command
> register.  You may want to break that into two lines of code.
> Give that a try!
>
> Open Systems International, Inc.
> Nathan Zeitler
> Hardware Engineer
> 3600 Holly Lane North, Suite 40
> Minneapolis, MN 55447-1286
> Phone: 763 551 0559
> Fax: 763 551 0750
> E-mail: nzeitler@osii.com
>


--
_______________________________
Allann J. O. Silva

"I received the fundamentals of my education in school, but that was
not enough. My real education, the superstructure, the details, the
true architecture, I got out of the public library. For an
impoverished child whose family could not afford to buy books, the
library was the open door to wonder and achievement, and I can never
be sufficiently grateful that I had the wit to charge through that
door and make the most of it." (from I. Asimov, 1994)
