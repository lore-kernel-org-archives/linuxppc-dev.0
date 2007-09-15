Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id 1080DDDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Sep 2007 01:55:47 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so837586rvf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 08:55:46 -0700 (PDT)
Message-ID: <9e4733910709150855k6ba6dc8fye9762817566208b4@mail.gmail.com>
Date: Sat, 15 Sep 2007 11:55:46 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: Domen's MPC5200 FEC cleanup patch.
In-Reply-To: <20070915122218.GB19857@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
	<9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>
	<20070915122218.GB19857@nd47.coderock.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/15/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> On 15/09/07 00:28 -0400, Jon Smirl wrote:
> > On 9/14/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > This patch doesn't seem to working quite right on my hardware (Phytec
> > > pcm030). At boot I get a long pause.
> >
> > It also doesn't compile if  CONFIG_FEC_MPC52xx_MDIO is undefined.
>
> Right, darn.
> Try this one: http://coderock.org/tmp/fec-v3rc1/

    0.776407] 0x00f40000-0x00f80000 : "oftree"
[    0.782101] 0x00f80000-0x01000000 : "space"
[    0.788100] TCP cubic registered
[    0.791427] NET: Registered protocol family 1
[    0.795904] NET: Registered protocol family 17
[    1.305579] f0003000:00 not found
[    1.308985] net eth0: phy_connect failed
[    1.312961] net eth0: fec_init_phy failed
[    1.317188] IP-Config: Failed to open eth0
[    1.321362] IP-Config: No network devices available.
[    1.326973] Looking up port of RPC 100003/3 on 192.168.1.4



>
> Does it work without phy-handle in device tree, but
> with this part being unconditional (fec.c):
>  709 //        if (priv->has_phy)
>  710                 rcntrl |= FEC_RCNTRL_MII_MODE;
>
> This effectively disables phy part of the driver,
> but still allows hardware to use PHY/MII.

Makes no difference

>
> I am puzzled by the symptoms you see.
>
>
>         Domen
>
> >
> > --
> > Jon Smirl
> > jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
