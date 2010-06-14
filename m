Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 9AD89B7D69
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 01:35:45 +1000 (EST)
Received: by gyf2 with SMTP id 2so2579270gyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 08:35:43 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <alpine.LFD.2.00.1006140943350.13427@xanadu.home>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com> <1276408773.1962.574.camel@pasglop>
	<AANLkTinwL0XtMNG13inr_1UliOlqZkyr4dlvG-ZGL9JT@mail.gmail.com>
	<alpine.LFD.2.00.1006140943350.13427@xanadu.home>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Jun 2010 09:35:23 -0600
Message-ID: <AANLkTim1mYpaxe-_OGbOF3AaZ6m5_SVUXLbeyKnAyvjs@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Olof Johansson <olof@lixom.net>, microblaze-uclinux@itee.uq.edu.au,
	Mitch Bradley <wmb@firmworks.com>, Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 14, 2010 at 7:51 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sun, 13 Jun 2010, Grant Likely wrote:
>
>> [cc'ing linux-arm-kernel]
>>
>> On Sat, Jun 12, 2010 at 11:59 PM, Benjamin Herrenschmidt
>> > BTW. I notice no ARM list is CCed on this discussion ... maybe we shou=
ld
>> > fix that ?
>>
>> cc'ing linux-arm-kernel in all my replies
>
> I'm afraid this won't be enough.
>
> I'm seeing a stream of frightening crazy talk involving ARM and some
> other stuff I still can't make head and tail of. =A0So, before you get a
> wholesale NAK on everything from me, please I'd suggest you guys rewind
> a bit now that the ARM list is in CC and just explain what this is all
> about and why we should feel concerned. =A0Then maybe the ARM savvy peopl=
e
> amongst us could suggest more appropriate approaches?

The discussion *started* with a request to review this document:

http://devicetree.org/Device_Tree_Usage

Which is in early draft form (which is why the arm list wasn't
initially cc'd. I was soliciting feedback from the current device tree
users.  A second request for review will go out after rework is done
to the document).

In one of the reply threads Mitch stated that he is working on an ARM
project that will use Open Firmware as the bootloader, and that he'd
like the ability to keep OFW available after the kernel is booted
which is something currently done on both Sparc and OLPC x86.  Mitch
will correct me if I'm made any misrepresentations here.

Conceptually I'm not opposed to allowing OFW to stay resident
providing that it does not impose new requirements on the boot
interface (the kernel would still need to be handed the flattened
representation of the device tree) and that the code to do so is well
contained in the kernel.  The devil is of course in the details on how
feasible it is to accomplish.  ARM machines with Open Firmware are
going to be the minority, so I'm not interested in doing anything
special or out of the ordinary specifically to support it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
