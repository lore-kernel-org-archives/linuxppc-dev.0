Subject: Re: [PATCH] Permedia2 fb on PPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: mzyngier@freesurf.fr
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <wrpg06lpawl.fsf@hina.wild-wind.fr.eu.org>
References: <wrpsnaq0xkx.fsf@hina.wild-wind.fr.eu.org>
	<1007572780.21734.65.camel@pismo>
	<wrpadwxth3m.fsf@hina.wild-wind.fr.eu.org> <1007848074.9125.10.camel@pismo>
	<wrpr8q5baho.fsf@hina.wild-wind.fr.eu.org> <1007851896.9146.12.camel@pismo>
	 <wrpg06lpawl.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 09 Dec 2001 00:43:32 +0100
Message-Id: <1007855012.9125.14.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2001-12-09 at 00:08, Marc ZYNGIER wrote:
>
> >>>>> "Michel" == Michel Dänzer <michdaen@iiic.ethz.ch> writes:
>
> Michel> As I said, the driver assumes the register aperture is big
> Michel> endian with Option "UseFBDev". And without, it will also try
> Michel> to use the big endian aperture.
>
> Well, with UseFBDev set to false, XFree works ok (although switching
> between consoles seems to be broken...).
>
> Michel> If there's really no way to use the big endian aperture on
> Michel> some boards, the only solution I see is to change both pm2fb
> Michel> and the glint driver to always use the little endian one.
>
> Indeed. What are the sparc people doing about that ? They are already
> using the little indian aperture in pm2gb.

I have only been talking about what glint does on PPC, maybe on sparc
it's already using the little endian aperture.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
