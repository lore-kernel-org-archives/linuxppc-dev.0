To: Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Permedia2 fb on PPC
References: <wrpsnaq0xkx.fsf@hina.wild-wind.fr.eu.org>
	<1007572780.21734.65.camel@pismo>
	<wrpadwxth3m.fsf@hina.wild-wind.fr.eu.org>
	<1007848074.9125.10.camel@pismo>
	<wrpr8q5baho.fsf@hina.wild-wind.fr.eu.org>
	<1007851896.9146.12.camel@pismo>
Reply-To: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 09 Dec 2001 00:08:58 +0100
Message-ID: <wrpg06lpawl.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <1007851896.9146.12.camel@pismo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Michel" == Michel Dänzer <michdaen@iiic.ethz.ch> writes:

Michel> As I said, the driver assumes the register aperture is big
Michel> endian with Option "UseFBDev". And without, it will also try
Michel> to use the big endian aperture.

Well, with UseFBDev set to false, XFree works ok (although switching
between consoles seems to be broken...).

Michel> If there's really no way to use the big endian aperture on
Michel> some boards, the only solution I see is to change both pm2fb
Michel> and the glint driver to always use the little endian one.

Indeed. What are the sparc people doing about that ? They are already
using the little indian aperture in pm2gb.

        M.
--
Places change, faces change. Life is so very strange.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
