Return-Path: <andrewd.lists@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.198])
	by ozlabs.org (Postfix) with ESMTP id EE64768352
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 17:11:57 +1000 (EST)
Received: by xproxy.gmail.com with SMTP id i27so316032wxd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 04 Oct 2005 00:11:56 -0700 (PDT)
Message-ID: <54823def0510040011m3e2ecfe6yae0d07187d5baeee@mail.gmail.com>
Date: Tue, 4 Oct 2005 17:11:56 +1000
From: Andrew Dennison <andrewd.lists@gmail.com>
To: Sylvain Munaut <tnt@246tnt.com>
In-Reply-To: <43421F87.2070501@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <81A66F72DCACD511B0600002A551BFCB08D9613C@kuumex05.barco.com>
	<54823def0510032131mee19acft6250ed99ce55ef21@mail.gmail.com>
	<43421F87.2070501@246tNt.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200 and pcmcia
Reply-To: Andrew Dennison <andrewd.lists@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/4/05, Sylvain Munaut <tnt@246tnt.com> wrote:
>
> IIRC, there is an errata wrt configuration cycle thru bridges.

I've got support for this (it's in my December patch). Configuration
cycles work but some cardbus cards / drivers cause a TEA when the
device is enabled driver loads Netgear FA511), while with a prism
based WLAN card (Netcomm NP5430) I can load the firmware into the card
but it doesn't run correctly - iwconfig can cause a TEA.

I haven't had time to work out how to debug these properly - other
more important things to do.

>
> > Apparnetly it's working in 2.6 but I haven't had time to sort this out.
>
> Is it ? not sure. I remember seeing a patch about it but it removed
> the "always 32 bit access" in all cases and not just in the needed case
> iirc. Make me think I forgot to sort that out ...

At one stange you mentioned you had a patch from someone for cardbus
support on 2.6 - it just fixed the configuration cycle errata so I
assumed this meant the rest "just worked". Maybe that was a bad
assumption...

Andrew
