Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
Date: Thu, 16 Apr 2009 15:37:58 +0200
References: <1239883845-17804-1-git-send-email-sr@denx.de>
	<fa686aa40904160626k118cea3cvc0db38a2277e45b8@mail.gmail.com>
In-Reply-To: <fa686aa40904160626k118cea3cvc0db38a2277e45b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904161537.59048.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 16 April 2009, Grant Likely wrote:
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Reviewd-by: Grant Likely <grant.likely@secretlab.ca>
>
> Yup, still looks good to me.  What boards has this been tested on?

I tested this version on PPC405EX Kilauea equipped only one "standard" 
Spansion S29GL512 NOR chip. And a slightly modified version on an MPC8360 
board (kmeter1) which is equipped with the Intel P30 part mentioned in the 
bindings description. Slightly modified since this board support is not yet 
pushed upstream and currently using v2.6.28 (physmap_of.c has received minor 
modifications after 2.6.28 release).

Thanks.

Best regards,
Stefan
