Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81B7AB6F01
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 00:30:20 +1000 (EST)
Date: Tue, 10 Aug 2010 15:43:37 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/6] Remove owner field from sysfs attribute structure
Message-ID: <20100810154337.006a0df9@hyperion.delvare>
In-Reply-To: <20100802233128.GA21286@kroah.com>
References: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
	<AANLkTinM+m15QbAg+J3YyHWnObsxtHYYU6p6C89p8wjp@mail.gmail.com>
	<20100802233128.GA21286@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jani Nikula <ext-jani.1.nikula@nokia.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	James Smart <james.smart@emulex.com>,
	Eric Biederman <ebiederm@aristanetworks.com>,
	Benjamin Thery <benjamin.thery@bull.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
	linuxppc-dev@ozlabs.org, "James E.J. Bottomley" <James.Bottomley@suse.de>,
	Richard Purdie <rpurdie@rpsys.net>, Nick Cheng <nick.cheng@areca.com.tw>,
	Dmitry Torokhov <dtor@mail.ru>, Tejun Heo <tj@kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Liam Girdwood <lrg@slimlogic.co.uk>, linux-scsi@vger.kernel.org,
	Alex Iannicelli <alex.iannicelli@emulex.com>,
	Guenter Roeck <guenter.roeck@ericsson.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2 Aug 2010 16:31:28 -0700, Greg KH wrote:
> On Wed, Jul 28, 2010 at 11:16:35PM -0700, Eric Biederman wrote:
> > On Wed, Jul 28, 2010 at 10:09 PM, Guenter Roeck
> > <guenter.roeck@ericsson.com> wrote:
> > > The following comment is found in include/linux/sysfs.h:
> > >
> > > =C2=A0 /* FIXME
> > > =C2=A0 =C2=A0* The *owner field is no longer used.
> > > =C2=A0 =C2=A0* x86 tree has been cleaned up. The owner
> > > =C2=A0 =C2=A0* attribute is still left for other arches.
> > > =C2=A0 =C2=A0*/
> > >
> > > As it turns out, the *owner field is (again?) initialized in several =
modules,
> > > suggesting that such initialization may be creeping back into the cod=
e.
> > >
> > > This patch set removes the above comment, the *owner field, and each =
instance
> > > in the code where it was found to be initialized.
> > >
> > > Compiled with x86 allmodconfig as well as with all alpha, arm, mips, =
powerpc,
> > > and sparc defconfig builds.
> >=20
> > This seems reasonable to me.  Can we get this in linux-next?
>=20
> It will show up in linux-next tomorrow.

Related bug?

https://bugzilla.kernel.org/show_bug.cgi?id=3D16544

--=20
Jean Delvare
