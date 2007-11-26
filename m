Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711260838s26e5b155n8d1cb2c246248394@mail.gmail.com>
Date: Mon, 26 Nov 2007 11:38:44 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <474AEB6A.40408@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
	<9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>
	<fa686aa40711190831s2e59ab05h63d10ec8a24eaad5@mail.gmail.com>
	<9e4733910711190851g3e1f2ef9k5f87c7c2dae929ef@mail.gmail.com>
	<fa686aa40711190933r3cbeb51bw7b9073a40f8396ed@mail.gmail.com>
	<9e4733910711191120l45d9257bwf4ccf8c7365393d0@mail.gmail.com>
	<fa686aa40711191128i59245403g3e15e3b6c545b6ee@mail.gmail.com>
	<20071120005941.GC3126@localhost.localdomain>
	<474AEB6A.40408@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/26/07, Timur Tabi <timur@freescale.com> wrote:
> David Gibson wrote:
>
> >       1) We have a "universal" device-tree-based fabric driver which
> > parses all the above-described interconnection information in the
> > device tree and handles any situation.  Cool, but probably a lot of
> > work and fiddly to get right.
>
> Definitely a lot of work.  I suggest we wait until there are a few PowerPC ASOC
> v2 audio drivers in the kernel before we even consider this.  And it may not
> even be possible.  I can easily imagine situations where we need board-specific
> code that belongs in a machine-specific fabric driver.

I'm fixing up the asoc v2 code to use MODULE_DEVICE_TABLE() and the
real kernel aliasing/insmod system. Half of why we are having trouble
is because asoc isn't using this mechanism. I've posted patches fixing
i2c to use the same mechanism.  I don't have the asoc ones ready yet.


>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
