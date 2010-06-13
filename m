Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 246BBB7D8B
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 15:07:30 +1000 (EST)
Received: by gxk21 with SMTP id 21so538899gxk.15
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 22:07:28 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276383132.1962.195.camel@pasglop>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 12 Jun 2010 23:07:08 -0600
Message-ID: <AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Olof Johansson <olof@lixom.net>, Mitch Bradley <wmb@firmworks.com>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 12, 2010 at 4:52 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2010-06-12 at 06:30 -1000, Mitch Bradley wrote:
>
>> I'm certainly going to try keeping OFW alive. =A0On the x86 OLPC machine=
s,
>> the ability to
>> dive into OFW via a SysRq key combo was very helpful for debugging some
>> difficult
>> problems. =A0The team has asked me to support the feature on ARM.
>
> Oh well, if you can and can convince the ARM kernel folks to do the
> necessary changes ... :-)

What is needed to keep OFW alive?  I've got no problem with doing so
if it isn't invasive, and as long as the same boot entry interface can
be used.

> One thing tho, you will only benefit from the whole infrastructure we
> have created accross platforms in linux if the device-tree is "sucked"
> into linux at boot. IE. Linux will not do constant accesses to OF for
> the DT. Even sparc converted to that now.
>
> That means that if your device-tree has a dynamic nature, we'll need to
> come up with a way to inform the kernel of changes in it so it can
> update it's copy accordingly.

What is the use-case for having a dynamic device tree?  I can see
keeping OFW alive being useful for some debug facilities, but once the
kernel has started, I'm really not interested in relying on firmware
to manage the hardware.  (but then again it's no secret that I'm
suspicious of anything that depends on runtime interaction with
firmware).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
