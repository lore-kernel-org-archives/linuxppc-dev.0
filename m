Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0126.hostedemail.com
 [216.40.44.126])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409TmG15WmzF2CQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 22:48:12 +1100 (AEDT)
Message-ID: <1522151285.12357.78.camel@perches.com>
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 patches@opensource.cirrus.com
Date: Tue, 27 Mar 2018 04:48:05 -0700
In-Reply-To: <5ec8703b-2979-7a1d-fbc3-bd528d7a5e29@roeck-us.net>
References: <1522096136.12357.21.camel@perches.com>
 <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
 <1522136107.12357.58.camel@perches.com>
 <5ec8703b-2979-7a1d-fbc3-bd528d7a5e29@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-27 at 03:28 -0700, Guenter Roeck wrote:
> On 03/27/2018 12:35 AM, Joe Perches wrote:
> > On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
> > > Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
> > 
> > fyi: It's marked Maintained in MAINTAINERS
> > 
> 
> I did not say that it was not maintained, and I am aware of the information
> in the MAINTAINERS file, thanks.

As am I.

I do agree that hwmon is obscure.  Almost everything about
anything is obscure to those that don't fully understand it.

I am unaware though of any use of "obsolete" in drivers/hwmon/
or in Documentation/ about hwmon or the wiki/

In what sense do you mean hwmon is obsolete?

And the cocci script?

Anything later than:
https://systeme.lip6.fr/pipermail/cocci/2016-December/003887.html
https://github.com/groeck/coccinelle-patches/tree/master/hwmon
?

btw: I think the perl scripts I posted for DEV_ATTR_<RW|RO|WO>
transforms are simpler and less prone to tool versioning
issues.

https://lkml.org/lkml/2017/12/22/844

It'd be fairly simple to add SENSOR_ support.
