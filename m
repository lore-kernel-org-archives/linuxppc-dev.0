Return-Path: <lennox.wu@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB552B6F92
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 18:02:58 +1000 (EST)
Received: by qwf7 with SMTP id 7so67875qwf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 01:02:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201106142222.43553.arnd@arndb.de>
References: <20110614190850.GA13526@linux-mips.org>
	<201106142222.43553.arnd@arndb.de>
Date: Wed, 15 Jun 2011 16:02:53 +0800
Message-ID: <BANLkTikpax09bQqwuP1dJYRtSO+c0DdUgg@mail.gmail.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
From: Lennox Wu <lennox.wu@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/alternative; boundary=0016364ecb745fc9a204a5bb94b9
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Russell King <linux@arm.linux.org.uk>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
	microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>,
	Mikael Starvik <starvik@axis.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
	Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364ecb745fc9a204a5bb94b9
Content-Type: text/plain; charset=ISO-8859-1

2011/6/15 Arnd Bergmann <arnd@arndb.de>
>
> >  config SCORE
> > -       def_bool y
> > -       select HAVE_GENERIC_HARDIRQS
> > -       select GENERIC_IRQ_SHOW
> > +     def_bool y
> > +     select HAVE_GENERIC_HARDIRQS
> > +     select HAVE_PC_PARPORT
> > +     select GENERIC_IRQ_SHOW
> >
> >  choice
> >       prompt "System type"
>
> Certainly not, no PIO support
>
>  Yes, there is no platform of the Score supports PIO.
Best,
Lennox

--0016364ecb745fc9a204a5bb94b9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/6/15 Arnd Bergmann <span dir=3D"ltr=
">&lt;<a href=3D"mailto:arnd@arndb.de">arnd@arndb.de</a>&gt;</span><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex;">
<div class=3D"im">
&gt; =A0config SCORE<br>
&gt; - =A0 =A0 =A0 def_bool y<br>
&gt; - =A0 =A0 =A0 select HAVE_GENERIC_HARDIRQS<br>
&gt; - =A0 =A0 =A0 select GENERIC_IRQ_SHOW<br>
&gt; + =A0 =A0 def_bool y<br>
&gt; + =A0 =A0 select HAVE_GENERIC_HARDIRQS<br>
&gt; + =A0 =A0 select HAVE_PC_PARPORT<br>
&gt; + =A0 =A0 select GENERIC_IRQ_SHOW<br>
&gt;<br>
&gt; =A0choice<br>
&gt; =A0 =A0 =A0 prompt &quot;System type&quot;<br>
<br>
</div>Certainly not, no PIO support<br>
<div class=3D"im"><br></div></blockquote><div>=A0Yes, there is no platform =
of the Score supports PIO.</div><div>Best,</div><div>Lennox</div></div>

--0016364ecb745fc9a204a5bb94b9--
