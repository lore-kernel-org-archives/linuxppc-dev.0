Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 17839B70F1
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2010 17:07:42 +1100 (EST)
Received: by iwn42 with SMTP id 42so535845iwn.15
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Nov 2010 22:07:41 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20101129055529.GB17113@yookeroo>
References: <1290607413.12457.44.camel@concordia>
	<1290692075.689.20.camel@concordia>
	<20101129055529.GB17113@yookeroo>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 28 Nov 2010 23:07:20 -0700
Message-ID: <AANLkTi=KBsMDvG2wZDu6ZtctWzd_bdQ=tO97eZu1R+VL@mail.gmail.com>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
To: Michael Ellerman <michael@ellerman.id.au>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 28, 2010 at 10:55 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Fri, Nov 26, 2010 at 12:34:35AM +1100, Michael Ellerman wrote:
>> Most of these are straight renames, but some have changed more
>> substantially. The routines for the flat tree have all become fdt_foo().
>
> I'm a little uneasy about using the same prefix as libfdt (fdt_foo())
> for routines that have a different implementation and different names
> / semantics to the libfdt routines.

I'd also be okay with either dtflat_ or flatdt_ for the prefix on
these routines.

g.
