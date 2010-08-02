Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CDFB6B70AA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 03:13:02 +1000 (EST)
Date: Mon, 2 Aug 2010 09:53:27 -0700
From: Greg KH <gregkh@suse.de>
To: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH 0/6] Remove owner field from sysfs attribute structure
Message-ID: <20100802165327.GA4814@suse.de>
References: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
	<4C52913C.9020204@kernel.org> <1280485690.1902.8.camel@pasglop>
	<20100730143622.GA30105@suse.de>
	<1280765724.5745.4.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280765724.5745.4.camel@groeck-laptop>
Cc: Nick Cheng <nick.cheng@areca.com.tw>,
	Jani Nikula <ext-jani.1.nikula@nokia.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	James Smart <james.smart@emulex.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"Eric W. Biederman" <ebiederm@aristanetworks.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@sous-sol.org>, Jean Delvare <khali@linux-fr.org>,
	"James E.J. Bottomley" <James.Bottomley@suse.de>,
	Richard Purdie <rpurdie@rpsys.net>,
	Alex Iannicelli <alex.iannicelli@emulex.com>,
	Dmitry Torokhov <dtor@mail.ru>, Tejun Heo <tj@kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Thery <benjamin.thery@bull.net>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 02, 2010 at 09:15:24AM -0700, Guenter Roeck wrote:
> On Fri, 2010-07-30 at 10:36 -0400, Greg KH wrote:
> > On Fri, Jul 30, 2010 at 08:28:10PM +1000, Benjamin Herrenschmidt wrote:
> > > On Fri, 2010-07-30 at 10:45 +0200, Tejun Heo wrote:
> > > > On 07/29/2010 07:09 AM, Guenter Roeck wrote:
> > > > > The following comment is found in include/linux/sysfs.h:
> > > > > 
> > > > >    /* FIXME
> > > > >     * The *owner field is no longer used.
> > > > >     * x86 tree has been cleaned up. The owner
> > > > >     * attribute is still left for other arches.
> > > > >     */
> > > > > 
> > > > > As it turns out, the *owner field is (again?) initialized in several modules,
> > > > > suggesting that such initialization may be creeping back into the code.
> > > > > 
> > > > > This patch set removes the above comment, the *owner field, and each instance
> > > > > in the code where it was found to be initialized.
> > > > > 
> > > > > Compiled with x86 allmodconfig as well as with all alpha, arm, mips, powerpc,
> > > > > and sparc defconfig builds.
> > > > 
> > > > Yeah, the change is way overdue.  Maybe we should have just removed
> > > > them back then.
> > > 
> > > I'm happy with the powerpc related patches as long as we all agree that
> > > needs to go. Do you need me to put some of this in powerpc.git or are
> > > you carrying them all to Linus ?
> > 
> > I can carry them all in my driver-core tree if you don't object.
> > 
> Any final verdict ? 
> 
> Not that it is my decision to make, but I think it would be better to
> have it all in one tree. Otherwise the timing for the last patch would
> get a bit complicated.

I'll take it.

thanks,

greg k-h
