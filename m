Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E911FB6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 04:30:02 +1000 (EST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <9e4733910908070934se43b2a9lfe72e89e0e247ea3@mail.gmail.com>
References: <9e4733910908070903p539b8987p8351df5b3d328fdd@mail.gmail.com>
	<fa686aa40908070915x7e04cbb8ofccd106230d5f76c@mail.gmail.com>
	<9e4733910908070934se43b2a9lfe72e89e0e247ea3@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 7 Aug 2009 12:29:40 -0600
Message-ID: <fa686aa40908071129i638e0e2ay9ad1a87d59d95615@mail.gmail.com>
Subject: Re: PSC clock divider
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 7, 2009 at 10:34 AM, Jon Smirl<jonsmirl@gmail.com> wrote:
> On Fri, Aug 7, 2009 at 12:15 PM, Grant Likely<grant.likely@secretlab.ca> wrote:
>>> Should I modify mpc52xx_set_psc_clkdiv() to take in a frequency and
>>> them move this code into mpc52xx_common.c? That allows the sysclk
>>> parameter to be eliminated for SPI.
>>
>> Yes, please do.
>
> Can mpc5xxx_clocks.c be eliminated and this function:
>
> mpc5xxx_get_bus_frequency(struct device_node *node)
>
> be moved into mpc52cc_common.c?

No.  mpc5xxx_get_bus_frequency is not mpc5200 specific.  It is used by
mpc5121 also.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
