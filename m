Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711191437j68d173e5v32888b9043cd757a@mail.gmail.com>
Date: Mon, 19 Nov 2007 17:37:00 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <4741BDA7.8020106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
	<9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>
	<4741BDA7.8020106@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/19/07, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
> > Now how do I pick which fabric driver to initialize?
>
> I'm doing it via a Kconfig option.  For ASoC V1, I think that's the only way
> that works.

I believe that is your only choice on v1. V1 is not set up to
correctly handle for device trees. It is fixed in v2 except for the
problem with how to load the fabric; no one has address that problem
yet. The sound portion of the code is pretty much the same between v1
and v2, it is all the driver setup code that has been reworked.


>
>
> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
