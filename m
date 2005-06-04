Return-Path: <edward.qin.hong@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.203])
	by ozlabs.org (Postfix) with ESMTP id 5403C67B19
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Jun 2005 09:40:44 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 16so1231876nzp
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 04 Jun 2005 16:40:42 -0700 (PDT)
Message-ID: <21fb73bc0506041640736e3020@mail.gmail.com>
Date: Sat, 4 Jun 2005 17:40:42 -0600
From: Edward Hong <edward.qin.hong@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050604011736.B199EC1512@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <21fb73bc05060316102325f94d@mail.gmail.com>
	<20050604011736.B199EC1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel ported from ELDK 3.0 hangs (loops in idled()) on my
	custom MPC870 Board
Reply-To: Edward Hong <edward.qin.hong@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/3/05, Wolfgang Denk <wd@denx.de> wrote:
> In message <21fb73bc05060316102325f94d@mail.gmail.com> you wrote:
> > I am trying to bring up Linux on a custom MPC870 Board using ELDK 3.0.
>=20
> Why are you using old (not to say ancient) tools?
>=20
I had the tool ready for a while. After porting u-boot, I realized
that there had been several new tool releases.

> > The ported kernel from ELDK 3.0 hangs (loops in idled()) and the kernel=
_thread
> > init never gets started!???
>=20
> How do you know that init didn't  run?  Runningthe  idle  loop  is  a
> perfectly normal situation.
>=20
My debug lines at the beginning of init never get printed on the
console or in the log_buf.

>=20
> Are you sure that your kernel configuration is sensible? For example,
> did you configure a console port that matches your hardware? Did  you
> configure the serial ports (SMC / SCC) at all?
>=20
I am positive about the kernel configuration. SMC1 was configured as my=20
console.

Any suggestions for debugging?

> Best regards,
>=20
> Wolfgang Denk
>=20
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> I read part of it all the way through.
>=20

Thank you!

Edward
