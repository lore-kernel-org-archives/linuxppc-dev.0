Return-Path: <sven@powerlinux.fr>
Date: Sun, 25 May 2008 03:22:28 +0200
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: Debian kernel updates for Cell platforms
Message-ID: <20080525012228.GA22268@powerlinux.fr>
References: <48389093.4000606@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48389093.4000606@am.sony.com>
From: Sven Luther <sven@powerlinux.fr>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	debian-powerpc@lists.debian.org,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 24, 2008 at 03:02:59PM -0700, Geoff Levand wrote:
> I made an updated debian config.powerpc64 to enable support for
> the PS3 and fix the QS20 and QS21 options.

Hi Geoff,

> I put a kernel, initrd and modules archive here:
> 
>   http://cell.gotdns.org/pub/debian-cell-kernel-1/

Thanks for taking the time to do this work. As well as thanks to Robert
Milan for having restarted work on cell support in debian.

> Could people please test and report on various powerpc64
> platforms.

So, this is still a generic kernel, which will boot on powermac G5, and
other powerpc 64 hardware, right ? 

I will look over the config on monday afternoon, and try to coordinate
the tests on various hardware, as well as do some early d-i work and
generate debain-installer images for testing.

BTW, you mentioned on irc that there where a couple patches that you
would like to be included in the debian kernel, when you provide those,
could you please include in the bug report also a quick rationale for
each of them, as well as some information on mainlain-ing status of
them, such as to have the best chance to convince our kernel team to
have them included.

Oh, and please bounce/forward this email to the debian-powerpc mailing
list, as my post will not reach it.

Friendly,

Sven Luther
