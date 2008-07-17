Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 6548CDE021
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 10:50:42 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 17 Jul 2008 02:49:11 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [HOW] binutils-2.17 breaks the 2.6.26 kernel
Message-ID: <20080717004911.GA13596@iram.es>
References: <1dce2aab6509053e60f7a59a30974749@bga.com>
	<9e4733910807161738g58da8bd7v78e9d50dc4d846cb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807161738g58da8bd7v78e9d50dc4d846cb@mail.gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Alan Modra <amodra@bigpond.net.au>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 08:38:14PM -0400, Jon Smirl wrote:
> On 7/16/08, Milton Miller <miltonm@bga.com> wrote:
> > Hi.
> 
> Previous threads have mentioned that binutil-2.17 is broken for
> building powerpc kernels. It is fixed in binutils-2.18.
> 
> I have encountered this and upgrading to 2.18 fixed my build. The
> symptom is large kernel sizes and a long time in gzip. In my case it
> was gziping a 2GB file.

Only? Mine was over 3GB :-)

I've not yet had time to update the binutils (the machine has
a standard Debian Etch and I have trouble when adding Lenny
sources).

I also bisected it for fun and got 366234f6 as the culprit.

	Gabriel
