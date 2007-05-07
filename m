Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 6121EDDE48
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 May 2007 11:17:39 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so770734ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 06 May 2007 18:17:37 -0700 (PDT)
Message-ID: <528646bc0705061817h7a8fd767v73195e9d4572b8e1@mail.gmail.com>
Date: Sun, 6 May 2007 19:17:37 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: virtex_devices.c
In-Reply-To: <528646bc0705061746s28ebb15et428c7afda2f477ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <463C379D.7020804@dlasys.net>
	<528646bc0705051516h2b0259cfgbe3be784acf4086a@mail.gmail.com>
	<463E4B13.2030600@dlasys.net>
	<528646bc0705061746s28ebb15et428c7afda2f477ba@mail.gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/6/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 5/6/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> >     The basic fundimental question is why is there an 8250 specific
> > structure,
> >     when there is a perfectly good generic structure that already exists ?
> >     Actually it seems to be even more complex than that because I think
> > there is actually an
> >     old_serial structure that is also used in places.
>
> I ask the opposite question; why try to make the 8250 structure
> generic when there is already a generic structure that does exactly
> what you want one level up?
>
> I *do* think that 8250 should be changed; but not in the way you're describing.

Although this point is actually moot because platform_bus pretty much
goes away when we move to arch/powerpc.  We'll be using
of_platform_devices instead (which map onto nodes in the device tree).

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
