Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A7A54DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 23:50:16 +1100 (EST)
Date: Wed, 22 Oct 2008 16:50:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/7] i2c: add info->archdata field
Message-ID: <20081022125014.GA27240@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171253.GB5515@oksana.dev.rtsoft.ru>
	<20081017112125.1f2c9d94@hyperion.delvare>
	<1224635254.7654.292.camel@pasglop>
	<20081022085002.0698e2a8@hyperion.delvare>
	<1224661075.7654.338.camel@pasglop>
	<20081022100813.GA24757@oksana.dev.rtsoft.ru>
	<20081022130748.57d4587a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081022130748.57d4587a@hyperion.delvare>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2008 at 01:07:48PM +0200, Jean Delvare wrote:
> On Wed, 22 Oct 2008 14:08:13 +0400, Anton Vorontsov wrote:
> > On Wed, Oct 22, 2008 at 06:37:55PM +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2008-10-22 at 08:50 +0200, Jean Delvare wrote:
> > > > On Wed, 22 Oct 2008 11:27:34 +1100, Benjamin Herrenschmidt wrote:
> > > > > On Fri, 2008-10-17 at 11:21 +0200, Jean Delvare wrote:
> > > > > > Hi Anton,
> > > > > > 
> > > > > > On Thu, 16 Oct 2008 21:12:53 +0400, Anton Vorontsov wrote:
> > > > > > > If present the info->archdata is copied into the dev->archdata.
> > > > > > > Some (OpenFirmware) platforms need it.
> > > > > > > 
> > > > > > > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > > > > > > ---
> > > > > 
> > > > > So who's pushing this one ? Jean ?
> > > > 
> > > > As I wrote before, I'm happy to take this patch if you want me to, but
> > > > I also have no objection if the author of this patchset wants to push
> > > > it himself together with the rest of the set. Just let me know what you
> > > > expect from me (preferably in the next few hours, as I will be sending
> > > > my second and last round of i2c patches for kernel 2.6.28 to Linus
> > > > today.)
> > > 
> > > Anton, I've done my last batch for 2.6.28 before -rc1 so it might be
> > > better if it goes through Jean no ?
> > 
> > Sorry, I guess the "few hours" limit was done exactly when I was
> > sleeping. ;-) Anyway, I'm fine either way. Don't see any problem
> > if it goes i2c or powerpc tree.
> 
> OK, then I'm taking the patch in my tree and it will go to Linus later
> today.

Much appreciated, thanks.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
