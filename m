Return-Path: <ebiederm@aristanetworks.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 3102FB70A5
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 16:16:37 +1000 (EST)
Received: by wye20 with SMTP id 20so160118wye.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 23:16:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
References: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
Date: Wed, 28 Jul 2010 23:16:35 -0700
Message-ID: <AANLkTinM+m15QbAg+J3YyHWnObsxtHYYU6p6C89p8wjp@mail.gmail.com>
Subject: Re: [PATCH 0/6] Remove owner field from sysfs attribute structure
From: Eric Biederman <ebiederm@aristanetworks.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jani Nikula <ext-jani.1.nikula@nokia.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	James Smart <james.smart@emulex.com>, linuxppc-dev@ozlabs.org,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
	Tejun Heo <tj@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@suse.de>,
	Richard Purdie <rpurdie@rpsys.net>, Nick Cheng <nick.cheng@areca.com.tw>,
	Dmitry Torokhov <dtor@mail.ru>, Jean Delvare <khali@linux-fr.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Thery <benjamin.thery@bull.net>, linux-scsi@vger.kernel.org,
	Alex Iannicelli <alex.iannicelli@emulex.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 28, 2010 at 10:09 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> The following comment is found in include/linux/sysfs.h:
>
> =A0 /* FIXME
> =A0 =A0* The *owner field is no longer used.
> =A0 =A0* x86 tree has been cleaned up. The owner
> =A0 =A0* attribute is still left for other arches.
> =A0 =A0*/
>
> As it turns out, the *owner field is (again?) initialized in several modu=
les,
> suggesting that such initialization may be creeping back into the code.
>
> This patch set removes the above comment, the *owner field, and each inst=
ance
> in the code where it was found to be initialized.
>
> Compiled with x86 allmodconfig as well as with all alpha, arm, mips, powe=
rpc,
> and sparc defconfig builds.

This seems reasonable to me.  Can we get this in linux-next?

Eric
