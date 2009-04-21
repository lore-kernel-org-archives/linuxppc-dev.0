Return-Path: <kyle@moffetthome.net>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id D1E38DE046
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 10:10:08 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so556240anc.39
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 17:10:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <625fc13d0904200529l152b8d75g33c3f940de1b2920@mail.gmail.com>
References: <f73f7ab80904171732n41832d0hc62978e57bbcc32e@mail.gmail.com>
	<625fc13d0904200529l152b8d75g33c3f940de1b2920@mail.gmail.com>
Date: Mon, 20 Apr 2009 20:10:05 -0400
Message-ID: <f73f7ab80904201710m57472291yf7ff86760977b8e8@mail.gmail.com>
Subject: Re: Porting the ibm_newemac driver to use phylib (and other PHY/MAC
	questions)
From: Kyle Moffett <kyle@moffetthome.net>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, netdev <netdev@vger.kernel.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 20, 2009 at 8:29 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wr=
ote:
> On Fri, Apr 17, 2009 at 8:32 PM, Kyle Moffett <kyle@moffetthome.net> wrot=
e:
>> Hello,
>>
>> I'm currently fiddling with a custom embedded prototype board using
>> the ibm_newemac driver with some currently-unsupported PHYs. =C2=A0Those
>> PHYs *are* supported by phylib, but the emac driver seems to have its
>> own PHY layer cribbed from the sungem driver. =C2=A0I'm curious if there=
's
>> some particular reason it hasn't been ported (aside from "nobody has
>> bothered yet").
>
> IIRC, Ben had some issues with how phylib and the EMAC would need to
> interact. =C2=A0Not sure if he has those written down somewhere or not.
> (CC'd).

Hmm, yeah, I'd be interested to see those.  There's enough similar
between phylib and the EMAC and sungem drivers that I'm considering a
series of somewhat-mechanical patches to make EMAC and sungem use the
"struct phy_device" and "struct mii_bus" from phylib, possibly
abstracting out some helper functions along the way.

>> Also, if I end up
>> going that route, are there others available with other hardware
>> variants who would be willing to test my patches on their boards?
>
> I have a large variety of boards that I can test with since the entire
> 4xx line relies on this driver for on-board network.

Wonderful!  If/when I hack together a patch series I'll make sure to
put you on the CC list.  Thanks!

Cheers,
Kyle Moffett
