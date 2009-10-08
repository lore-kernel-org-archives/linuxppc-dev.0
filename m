Return-Path: <avorontsov@ru.mvista.com>
Date: Thu, 8 Oct 2009 19:10:07 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Message-ID: <20091008151007.GA21328@oksana.dev.rtsoft.ru>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 08, 2009 at 08:53:46AM -0600, Grant Likely wrote:
[...]
> Please don't.  It is such a small amount of code,

It's *always* a small amound of code, at a start. Then we get
floppy disk drivers and the tty layer. ;-)

[...]
> Driver writers shouldn't have to
> write anything more than a tiny function to populate pdata from the
> device tree.  Managing that pdata instance needs to be done with
> common infrastructure (but I don't have a firm idea about how it
> should look yet).  In the mean time I think Wolfram's approach has
> lower impact.

If I wasn't a PPC/OF guy to some degree, I'd hate PPC/OF people
for bringing arch-specific details into a generic code... :-P

No matter how small the OF code is, I believe we shouldn't put it
into the generic code. Take a look at mmc_spi case again, it can be
easily extended to any arch, because there is no arch-specific stuff,
but a "get/put" pattern for platform data.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
