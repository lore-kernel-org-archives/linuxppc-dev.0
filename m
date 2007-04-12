Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 3/3] cell: prevent alignment interrupt on local store
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070412042337.GA21832@aepfle.de>
References: <20070410111508.GA2969@localhost.localdomain>
	<1176240168.8061.51.camel@localhost.localdomain>
	<20070411025605.GB2197@localhost.localdomain>
	<1176262253.8061.60.camel@localhost.localdomain>
	<ffb78cbadfea8d104c8e5d495e9651ca@kernel.crashing.org>
	<20070412042337.GA21832@aepfle.de>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 15:26:06 +1000
Message-Id: <1176355566.8061.121.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <mita@fixstars.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-12 at 06:23 +0200, Olaf Hering wrote:
> On Wed, Apr 11, Segher Boessenkool wrote:
> 
> > This isn't just a kernel issue either; the same holds
> > for all of userspace.  It seems to me the only way to
> > get good performance on both Cell and all other platforms
> > is to have a separate binary distribution for Cell.
> 
> How much will this impact performance on a 970, 74xx or POWER6 if
> everything gets compiled with '--mcpu=$cell', compared to what is used
> today? One gets at least altivec that way.

Gets altivec and stops working on POWER5 ? no deal :-)

Ben.
