Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Sun, 16 Nov 2003 23:07:01 -0700
To: Wolfgang Denk <wd@denx.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031117060701.GA26252@zenos.farnsworth.org>
References: <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net> <20031116203318.21D9CC5F59@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031116203318.21D9CC5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 16, 2003 at 08:33:13PM +0000, Wolfgang Denk wrote:
> Dear Tom & Dale,
>
> OK, so the discussion has stopped. What's happening now? I  sent  our
> stuff.  Dale  has  added some modification. We have more works in the
> queue. I think it makes little sense to  continue  without  a  common
> code base.
>
> Can you give any estimates when something will go into a public tree,
> and what this will be, and which tree?
>
> If there is any reason for you not to use the  "common"  trees  (like
> linuxppc_2_4_devel  ?)  yet,  maybe  we  can at least put the current
> state into a more dedicated tree like
> bk://source.mvista.com/linuxppc_2_4_mgt5100
>
> So that we can at least avoid to duplicate efforts while the work  is
> going on?

Hi Wolfgang,

Have you had a chance to test my merged patch?  Any bug fixes?  I don't
think it's quite ready for linuxppc_2_4_devel, though it's close.

Per your suggestion above, I created
bk://source.mvista.com/linuxppc_2_4_mpc5200

It incorporates my merged patch with the following changes from the
discussion in this thread:
	o s/CONFIG_5XXX/CONFIG_PPC_5xxx/
	o s/i2c-algo-m5xxx.c/i2c-algo-ppc_5xxx.c/
	o s/UBoot/U-Boot/
	o s/M?5[xX][xX][xX]/MPC5xxx/
	o s/m?5[xX][xX][xX]/mpc5xxx/
	o changed default CONFIG_MPC5xxx_FLASH_SIZE to 0x1000000

I think the name changes are a definite improvement.  Thanks to all
for the input.

Please try this new tree and submit patches against it.

Thank you,
-Dale Farnsworth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
