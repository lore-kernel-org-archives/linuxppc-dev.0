Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311035o4b95b83ficed437d463f2ad37@mail.gmail.com>
Date: Thu, 31 Jul 2008 13:35:58 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <4891F4D8.9090905@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <488982B5.4070102@grandegger.com> <48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
Cc: Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>,
	Linux I2C <i2c@lm-sensors.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/31/08, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Jon Smirl wrote:
> > There appears to be one for i2x8xxx but not the other CPUs.
> >
> > /* I2C
> > */
> > typedef struct i2c {
> >        u_char  i2c_i2mod;
> >        char    res1[3];
> >        u_char  i2c_i2add;
> >        char    res2[3];
> >        u_char  i2c_i2brg;
> >        char    res3[3];
> >        u_char  i2c_i2com;
> >        char    res4[3];
> >        u_char  i2c_i2cer;
> >        char    res5[3];
> >        u_char  i2c_i2cmr;
> >        char    res6[0x8b];
> > } i2c8xx_t;
> >
>
>  The I2C interface for the MPC5200 is not compatible with the one for the
> MPC83/4/5/6xx, AFAIK.

Ignore that table, I mistook MPC8xx for MPC8xxx. That is a MPC8xx table.

>
>  Wolfgang.
>


-- 
Jon Smirl
jonsmirl@gmail.com
