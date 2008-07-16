Return-Path: <rene.herman@keyaccess.nl>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201]) by ozlabs.org (Postfix) with ESMTP id 754D6DDFA1
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 19:04:23 +1000 (EST)
Message-ID: <487DACBB.6000909@keyaccess.nl>
Date: Wed, 16 Jul 2008 10:09:31 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC] (almost) booting allyesconfig -- please don't poke super-io
	without request_region
References: <for-27-patch1-0@bga.com>	<4879A144.8060203@hhs.nl>	<4dfa50520807131411ied883cgcb20eb6bd94f761@mail.gmail.com>	<487A7211.7030309@hhs.nl>	<4dfa50520807131426t4013142cp1fcd49e078a79c1f@mail.gmail.com>	<20080714095914.0644ac5d@hyperion.delvare>	<88f5162604470179b3c6ebfe729a46f5@bga.com>	<487B8D2C.1090208@hhs.nl>	<4dfa50520807141055l532caaaai700255936600e5ae@mail.gmail.com>	<20080715103613.4fbbf01f@hyperion.delvare>	<4dfa50520807150831i519a3a43n635ab7e58d35ba5e@mail.gmail.com>
	<20080716094602.4379e0ff@hyperion.delvare>
In-Reply-To: <20080716094602.4379e0ff@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Samuel Ortiz <samuel@sortiz.org>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, Hans de Goede <j.w.r.degoede@hhs.nl>,
	David Hubbard <david.c.hubbard@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 16-07-08 09:46, Jean Delvare wrote:

> As a conclusion, there is no clear relationship between the presence
> of an ISA or LPC bridge and the presence of a Super-I/O chip. All we
> can say is that apparently all PC systems have an ISA bridge. So
> indeed we can probably make the probes conditional upon the presence
> of an "ISA bridge" PCI device. That's very easy to test. In practice
> it might be equivalent to making the driver x86-only.

And foregoing non (pre-) PCI. Admittedly, that might not be much of an 
issue and I don't know if "Super-I/O" is maybe even defined such as to 
make it a NON issue but I do for example remember my old 386 chipset 
providing for extended serial rates which I thought was way cool back 
then. If that's Super-I/O (or something that should/could be covered by 
the infrastructure at least) then PCI wouldn't be helpful.

Rene.
