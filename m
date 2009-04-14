Return-Path: <avorontsov@ru.mvista.com>
Date: Wed, 15 Apr 2009 01:27:24 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [BUILD FAILURE 11/12] Next April 14 : PPC64 randconfig
	[drivers/spi/mpc52xx_psc_spi.c]
Message-ID: <20090414212724.GA12371@oksana.dev.rtsoft.ru>
References: <1239733836.5344.83.camel@subratamodak.linux.ibm.com>
	<fa686aa40904141142s3717812ep293973fefce8853d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40904141142s3717812ep293973fefce8853d@mail.gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	David Brownell <dbrownell@users.sourceforge.net>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>, subrata@linux.vnet.ibm.com,
	Alexander Beregalov <a.beregalov@gmail.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 14, 2009 at 12:42:47PM -0600, Grant Likely wrote:
> Thanks Subrata.  I'll look into this.

Whoops. That's my fault, I didn't expect that anyone other
than spi_mpc83xx is using fsl_spi_platform_data. :-/

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
