Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0A892DE89B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 01:49:07 +1000 (EST)
Date: Tue, 26 Aug 2008 19:49:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/3] Patches to support QE USB Host Controller
Message-ID: <20080826154904.GA26294@oksana.dev.rtsoft.ru>
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
	<20080808232635.GB5352@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080808232635.GB5352@kroah.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 08, 2008 at 04:26:35PM -0700, Greg KH wrote:
> On Fri, Aug 08, 2008 at 08:17:17PM +0400, Anton Vorontsov wrote:
> > Hi all,
> > 
> > Most patches that were needed to support QE USB Host were merged during
> > 2.6.27 merge window, and only three more patches left over. Here they
> > are.
> > 
> > David, could you bear with gpio_to_chip() exported function, just as
> > a stopgap for a proper api?
> 
> I'll hold off on the 3rd patch until david takes the first two.

David, are there any issues with the first patch in the series?

It would be great if you'll ack the first patch, so that I'll
respin the whole patchset with some minor fixes in the 3rd patch.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
