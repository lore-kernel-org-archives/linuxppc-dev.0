Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id AF183B7C15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 07:50:26 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 03/13] mpc52xx: add SCLPC register bit definitions
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa41001111121u5c943fc7p789c0ec0b41af883@mail.gmail.com>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220800.54373.roman.fietze@telemotive.de>
	<fa686aa41001111121u5c943fc7p789c0ec0b41af883@mail.gmail.com>
Date: Mon, 11 Jan 2010 21:50:25 +0100
Message-Id: <20100111205025.0C96E3F6DA@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa41001111121u5c943fc7p789c0ec0b41af883@mail.gmail.com> you wrote:
>
> >  /* mpc52xx_lpbfifo.c */
> >  #define MPC52XX_LPBFIFO_FLAG_READ              (0)
> > -#define MPC52XX_LPBFIFO_FLAG_WRITE             (1<<0)
> > -#define MPC52XX_LPBFIFO_FLAG_NO_INCREMENT      (1<<1)
> > -#define MPC52XX_LPBFIFO_FLAG_NO_DMA            (1<<2)
> > -#define MPC52XX_LPBFIFO_FLAG_POLL_DMA          (1<<3)
> > +#define MPC52XX_LPBFIFO_FLAG_WRITE             BIT(0)
> > +#define MPC52XX_LPBFIFO_FLAG_NO_INCREMENT      BIT(1)
> > +#define MPC52XX_LPBFIFO_FLAG_NO_DMA            BIT(2)
> > +#define MPC52XX_LPBFIFO_FLAG_POLL_DMA          BIT(3)
> 
> I prefer the (1<<n) style myself.

Indeed, especially as one can argue that "(1<<0)" should be "BIT(31)"
on Power Architecture systems, where bit 0 is the MSB by definition.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Do not simplify the design of a program if a way can be found to make
it complex and wonderful.
