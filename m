Return-Path: <bob.picco@hp.com>
Received: from ccerelrim01.cce.hp.com (smtp.cce.hp.com [161.114.21.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ccerelrim01.cce.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id B5C30DDED2
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 03:24:28 +1000 (EST)
From: "Bob Picco" <bob.picco@hp.com>
Date: Wed, 16 May 2007 13:24:21 -0400
To: Olof Johansson <olof@lixom.net>
Subject: Re: your mail
Message-ID: <20070516172421.GC25792@localhost>
References: <20070516133046.GB25792@localhost>
	<20070516164341.GA7008@austin.ibm.com>
	<20070516171100.GA25056@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070516171100.GA25056@lixom.net>
Cc: linux-kernel@vger.kernel.org, Bob Picco <bob.picco@hp.com>,
	linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, johnrose@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:	[Wed May 16 2007, 01:11:00PM EDT]
> On Wed, May 16, 2007 at 11:43:41AM -0500, Linas Vepstas wrote:
> > On Wed, May 16, 2007 at 09:30:46AM -0400, Bob Picco wrote:
> > > Subject: Re: 2.6.22-rc1-mm1 powerpc build breakage
> > > 
> > > /usr/src/linux-2.6.22-rc1-mm1/drivers/pci/hotplug/rpadlpar_sysfs.c:132: error: unknown field `subsys' specified in initializer
> > > /usr/src/linux-2.6.22-rc1-mm1/drivers/pci/hotplug/rpadlpar_sysfs.c:132: warning: initialization from incompatible pointer type
> > > make[4]: *** [drivers/pci/hotplug/rpadlpar_sysfs.o] Error 1
> > > make[3]: *** [drivers/pci/hotplug] Error 2
> > > make[2]: *** [drivers/pci] Error 2
> > > make[1]: *** [drivers] Error 2
> > > make: *** [_all] Error 2
> > 
> > John Rose is working to fix this "real soon now".
> 
> Do you mean the fix Al Viro posted yesterday?
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=11177
> 
> 
> -Olof
Missed that patch.

thanks,

bob
