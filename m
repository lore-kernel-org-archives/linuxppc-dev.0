Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40806111835t1ad70f54td8c30901056f919f@mail.gmail.com>
Date: Wed, 11 Jun 2008 19:35:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: mpc52xx_psc.h
In-Reply-To: <9e4733910806111405nc5b45fg33b5107927f8d5f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806111405nc5b45fg33b5107927f8d5f1@mail.gmail.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2008 at 3:05 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Why was the fifo struct separated from the psc struct for the 5200?
>
> I see comments like this now:
>        /* On the 5200, fifo regs are immediately adjacent to the psc regs */
>        mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
>
> Couldn't the fifo struct be a member at the end of the psc struct?

The mpc5121 uses the same PSC register structure, but the fifo regs
are no longer adjacent.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
