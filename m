Return-Path: <randy.dunlap@oracle.com>
Message-ID: <49EE8855.1080306@oracle.com>
Date: Tue, 21 Apr 2009 20:00:37 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [BUILD FAILURE 11/12] Next April 21 : PPC64 randconfig
	[drivers/usb/host/ohci-hcd.o]
References: <1240340081.9110.144.camel@subratamodak.linux.ibm.com>
	<5A202317-5104-4784-845B-B8C46E0A3C48@kernel.crashing.org>
	<49EE4341.50701@oracle.com>
	<200904211919.38104.david-b@pacbell.net>
In-Reply-To: <200904211919.38104.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, samr <sam@ravnborg.org>,
	linux-usb@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, subrata@linux.vnet.ibm.com,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Brownell wrote:
> On Tuesday 21 April 2009, Randy Dunlap wrote:
>>> Since its feasible to say 'n' to both we get the compile error.  How do
>>> we enforce having at least one set?
>> Looks like using "choice" without "optional" would do it.
>> See Documentation/kbuild/kconfig-language.txt and various examples
>> in Kconfig* files.
> 
> That won't quite work ... "at least one" includes "two"
> (i.e. a PCI card in little-endian, a native controller
> in big-endian).  Real-world systems need such configs,
> or so I'm told, and that's why their supported.

Yes, I see.

> Is there maybe a way to force Kconfig to just reject
> such illegal configs -- neither option set -- rather
> than trying some how to fix it?

Not that I know of.  cc-ing Sam.

> Or maybe ... if neither one is set, have the header
> force both on, and issue a warning.

That should be doable.  We'd prefer to catch it via Kconfig,
but that doesn't look promising just now.

-- 
~Randy
