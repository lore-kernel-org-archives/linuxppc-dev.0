Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DC152B7142
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 06:06:44 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40906171115m3e3faab2r63814ea8013056d0@mail.gmail.com>
References: <20090605182651.24094.36577.sendpatchset@elm3a191.beaverton.ibm.com>
	<200906091738.58154.david-b@pacbell.net>
	<1244799348.5234.13.camel@subratamodak.linux.ibm.com>
	<1245048679.5239.8.camel@subratamodak.linux.ibm.com>
	<1245243186.4870.5.camel@subratamodak.linux.ibm.com>
	<fa686aa40906171115m3e3faab2r63814ea8013056d0@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Jun 2009 14:06:21 -0600
Message-ID: <fa686aa40906171306l3cfe5459j65f11b100f23bfd@mail.gmail.com>
Subject: Re: [BUILD FAILURE 02/04] Next June 04:PPC64 randconfig
	[drivers/usb/host/ohci-hcd.o]
To: subrata@linux.vnet.ibm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Randy Dunlap <randy.dunlap@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-usb@vger.kernel.org,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>, kernel@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17, 2009 at 12:15 PM, Grant Likely<grant.likely@secretlab.ca> w=
rote:
> On Wed, Jun 17, 2009 at 6:53 AM, Subrata
> Modak<subrata@linux.vnet.ibm.com> wrote:
>> On Mon, 2009-06-15 at 12:21 +0530, Subrata Modak wrote:
>>> On Fri, 2009-06-12 at 15:05 +0530, Subrata Modak wrote:
>>> > On Tue, 2009-06-09 at 17:38 -0700, David Brownell wrote:
>>> > > On Friday 05 June 2009, Subrata Modak wrote:
>>> > > > Correct, it fixes the issue. However, since few changes might hav=
e gone
>>> > > > to the Kconfig, the patch does not apply cleanly. Below is the pa=
tch, just
>>> > > > a retake of the earlier one, but on the latest code.
>>> > >
>>> > > And it got mangled a bit along the way. =A0Plus, the original one
>>> > > goofed up Kconfig dependency displays ... both issues fixed in
>>> > > this version, against current mainline GIT.
>>> > >
>>> > > If someone can verify all four PPC/OF/OHCI configs build on
>>> > > on PPC64, I'm OK with it.
>>> > >
>>> > > - Dave
>>> >
>>> > Dave,
>>> >
>>> > Sorry for being late. The patch fixes the issue on the latest git for
>>> > PPC64. Infact, the whole drivers/usb/host/ builds just fine:
>>> >
>>> > linux-2.6 # make drivers/usb/host/
>>> > =A0 CHK =A0 =A0 include/linux/version.h
>>> > =A0 CHK =A0 =A0 include/linux/utsrelease.h
>>> > =A0 SYMLINK include/asm -> include/asm-powerpc
>>> > =A0 CALL =A0 =A0scripts/checksyscalls.sh
>>> > =A0 CC =A0 =A0 =A0drivers/usb/host/ohci-hcd.o
>>> > =A0 CC =A0 =A0 =A0drivers/usb/host/pci-quirks.o
>>> > =A0 CC =A0 =A0 =A0drivers/usb/host/uhci-hcd.o
>>> > =A0 LD =A0 =A0 =A0drivers/usb/host/built-in.o
>>> > =A0 CC [M] =A0drivers/usb/host/isp116x-hcd.o
>>> > =A0 CC [M] =A0drivers/usb/host/u132-hcd.o
>>> >
>>> > You can check in the patch now.
>>>
>>> Dave,
>>>
>>> Have you checked in this patch ? Or, does it require some more
>>> modification/updates from somebody=B4s side ?
>>>
>>
>> Dave,
>>
>> Would you consider checking in this patch ?
>
> Hold off please; give me a couple of hours to investigate.

Never mind; I replied to the wrong email.  Please ignore my comments.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
