Date: Wed, 16 Apr 2003 19:23:54 -0700
From: Matt Porter <porter@cox.net>
To: Xupei Liang <tliang@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc4xx_setup.c for PPC440
Message-ID: <20030416192354.A16095@home.com>
References: <20030417014956.91452.qmail@web11004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030417014956.91452.qmail@web11004.mail.yahoo.com>; from tliang@yahoo.com on Wed, Apr 16, 2003 at 06:49:56PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 16, 2003 at 06:49:56PM -0700, Xupei Liang wrote:
> I am working on porting Linux 2.4.19 to support a
> PPC440-based board. I noticed that there is a file
> called ppc4xx_setup.c for PPC405-based boards.
> However, there isn't an equivalent file for PPC440.
> Is ppc4xx_setup.c intended to support all ppc4xx
> product?

No, PPC440 doesn't follow the ppc40x model of all ports
flowing through a common file.  An unfinished piece of
business is abstracting pieces of ebony.c into a
ppc44x_common.c where your <board>.c can call the
ppc44x_common.c shared routines.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
