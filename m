Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A8CE1007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 20:55:59 +1000 (EST)
Subject: Re: [PATCH 0/6] Remove owner field from sysfs attribute structure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4C52913C.9020204@kernel.org>
References: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
	<4C52913C.9020204@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Jul 2010 20:28:10 +1000
Message-ID: <1280485690.1902.8.camel@pasglop>
Mime-Version: 1.0
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	James Smart <james.smart@emulex.com>,
	"Eric W. Biederman" <ebiederm@aristanetworks.com>,
	Dmitry Torokhov <dtor@mail.ru>, Benjamin Thery <benjamin.thery@bull.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
	linuxppc-dev@ozlabs.org, "James E.J. Bottomley" <James.Bottomley@suse.de>,
	Paul Mackerras <paulus@samba.org>, Nick Cheng <nick.cheng@areca.com.tw>,
	Jani Nikula <ext-jani.1.nikula@nokia.com>,
	Jean Delvare <khali@linux-fr.org>, Richard Purdie <rpurdie@rpsys.net>,
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

On Fri, 2010-07-30 at 10:45 +0200, Tejun Heo wrote:
> On 07/29/2010 07:09 AM, Guenter Roeck wrote:
> > The following comment is found in include/linux/sysfs.h:
> > 
> >    /* FIXME
> >     * The *owner field is no longer used.
> >     * x86 tree has been cleaned up. The owner
> >     * attribute is still left for other arches.
> >     */
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
> Yeah, the change is way overdue.  Maybe we should have just removed
> them back then.

I'm happy with the powerpc related patches as long as we all agree that
needs to go. Do you need me to put some of this in powerpc.git or are
you carrying them all to Linus ?

Cheers,
Ben.

>  Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 
