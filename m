Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5B6A4B70D0
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 09:32:12 +1000 (EST)
Date: Mon, 2 Aug 2010 16:31:28 -0700
From: Greg KH <greg@kroah.com>
To: Eric Biederman <ebiederm@aristanetworks.com>
Subject: Re: [PATCH 0/6] Remove owner field from sysfs attribute structure
Message-ID: <20100802233128.GA21286@kroah.com>
References: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
	<AANLkTinM+m15QbAg+J3YyHWnObsxtHYYU6p6C89p8wjp@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTinM+m15QbAg+J3YyHWnObsxtHYYU6p6C89p8wjp@mail.gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jani Nikula <ext-jani.1.nikula@nokia.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	James Smart <james.smart@emulex.com>, linuxppc-dev@ozlabs.org,
	Benjamin Thery <benjamin.thery@bull.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
	Tejun Heo <tj@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@suse.de>,
	Richard Purdie <rpurdie@rpsys.net>, Nick Cheng <nick.cheng@areca.com.tw>,
	Dmitry Torokhov <dtor@mail.ru>, Jean Delvare <khali@linux-fr.org>,
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

On Wed, Jul 28, 2010 at 11:16:35PM -0700, Eric Biederman wrote:
> On Wed, Jul 28, 2010 at 10:09 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > The following comment is found in include/linux/sysfs.h:
> >
> >   /* FIXME
> >    * The *owner field is no longer used.
> >    * x86 tree has been cleaned up. The owner
> >    * attribute is still left for other arches.
> >    */
> >
> > As it turns out, the *owner field is (again?) initialized in several modules,
> > suggesting that such initialization may be creeping back into the code.
> >
> > This patch set removes the above comment, the *owner field, and each instance
> > in the code where it was found to be initialized.
> >
> > Compiled with x86 allmodconfig as well as with all alpha, arm, mips, powerpc,
> > and sparc defconfig builds.
> 
> This seems reasonable to me.  Can we get this in linux-next?

It will show up in linux-next tomorrow.

thanks,

greg k-h
