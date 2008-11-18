Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Nov 2008 11:28:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: powerpc: udbg based backend for hvc_console
Message-ID: <20081118002828.GB26336@yookeroo.seuss>
References: <20081024035434.GF4267@yookeroo.seuss>
	<ed82fe3e0811171141x1522c2c7i30711f6d69076df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0811171141x1522c2c7i30711f6d69076df@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2008 at 01:41:24PM -0600, Timur Tabi wrote:
> On Thu, Oct 23, 2008 at 9:54 PM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> > This patch adds a new backend for the hvc console based on the
> > low-level udbg callbacks.  This effectively implements a working
> > runtime console in terms of the simple udbg primitives.  This is kind
> > of a hack - since udbg isn't something you really want to be using
> > routinely - but it's really useful during bringup.
> 
> David, I have a stupid question.  I already have an HVC console driver
> that works.  Do I need to do anything, other than enable HVC_UDBG, to
> get my hvc console drive to use udbg?

Um.. well.. if you have both activated, I think you can select which
HVC console backend will be used by using console=/dev/hvcNN on the
commandline, where values of NN correspond to different backends, in
order depending on link order in some complex fashion.

But if you already have a working HVC console driver, I don't see why
you'd want to use HVC_UDBG - it's essentially a bringup hack.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
