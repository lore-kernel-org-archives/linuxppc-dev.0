Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40711191128i59245403g3e15e3b6c545b6ee@mail.gmail.com>
Date: Mon, 19 Nov 2007 12:28:02 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <9e4733910711191120l45d9257bwf4ccf8c7365393d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
	<9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>
	<fa686aa40711190831s2e59ab05h63d10ec8a24eaad5@mail.gmail.com>
	<9e4733910711190851g3e1f2ef9k5f87c7c2dae929ef@mail.gmail.com>
	<fa686aa40711190933r3cbeb51bw7b9073a40f8396ed@mail.gmail.com>
	<9e4733910711191120l45d9257bwf4ccf8c7365393d0@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 11/19/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > You might be stuck with using either a platform_device or an
> > of_platform_device as a stepping stone to creating the device on the
> > ALSA fabric driver.
>
> I also concluded that I need a of_platform stepping stone.
>
> There are several ways this could be done, which one is the right one?
> a) fabric is global, create a global device node for it and implement
> it as a of_platform device

This is really board level description stuff.  I'd make the node
global off the root myself and use whatever linkage you think
appropriate to get you to the codec nodes (phandle's most likely)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
