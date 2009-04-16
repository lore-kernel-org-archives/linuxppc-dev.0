Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <200904161537.59048.sr@denx.de>
References: <1239883845-17804-1-git-send-email-sr@denx.de>
	<fa686aa40904160626k118cea3cvc0db38a2277e45b8@mail.gmail.com>
	<200904161537.59048.sr@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Apr 2009 07:46:07 -0600
Message-ID: <fa686aa40904160646v75a98e02s446fd89c08cfebae@mail.gmail.com>
Subject: Re: [PATCH 1/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 7:37 AM, Stefan Roese <sr@denx.de> wrote:
> On Thursday 16 April 2009, Grant Likely wrote:
>> > Signed-off-by: Stefan Roese <sr@denx.de>
>> > Reviewd-by: Grant Likely <grant.likely@secretlab.ca>
>>
>> Yup, still looks good to me. =A0What boards has this been tested on?
>
> I tested this version on PPC405EX Kilauea equipped only one "standard"
> Spansion S29GL512 NOR chip. And a slightly modified version on an MPC8360
> board (kmeter1) which is equipped with the Intel P30 part mentioned in th=
e
> bindings description. Slightly modified since this board support is not y=
et
> pushed upstream and currently using v2.6.28 (physmap_of.c has received mi=
nor
> modifications after 2.6.28 release).

Okay.  It will be good to get this one into -next for some testing
exposure.  Unless he asks me to do otherwise, I'll leave this one to
David to pick up.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
