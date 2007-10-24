Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710240808r5d634905t6ba81c802e8f123a@mail.gmail.com>
Date: Wed, 24 Oct 2007 09:08:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <471F52ED.10007@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Timur Tabi <timur@freescale.com> wrote:
> >       codec0: i2s-codec@0 {
> >             compatible = "ti,tas5508";
> >             reg = <0>;
> >             i2s-handle = <&i2s@2000>;
> >       };
>
> I'd do this the other way around -- that is:
>
> i2s@2200 {           // PSC2
>         compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
>         ...
>         i2c-handle = <&codec0>;  /* Or something like that */

i2c-handle is a poor property name here.  It should be 'codec-handle'.
 The codec could theoretically live on just about *any* control bus;
not just i2c.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
