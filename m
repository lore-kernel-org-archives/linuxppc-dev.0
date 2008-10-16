Return-Path: <geert@linux-m68k.org>
Received: from yergi.telenet-ops.be (yergi.telenet-ops.be [195.130.132.36])
	by ozlabs.org (Postfix) with ESMTP id C4974DDDD4
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 18:58:44 +1100 (EST)
Received: from harold.telenet-ops.be (unknown [195.130.133.65])
	by yergi.telenet-ops.be (Postfix) with ESMTP id 95EDC71009A
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 09:58:43 +0200 (CEST)
Date: Thu, 16 Oct 2008 09:58:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: David Miller <davem@davemloft.net>
Subject: Re: powerpc allmodconfig
In-Reply-To: <20081016.003644.74134312.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0810160958000.25933@anakin>
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<20081015.220247.262683261.davem@davemloft.net>
	<Pine.LNX.4.64.0810160930300.25933@anakin>
	<20081016.003644.74134312.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bzolnier@gmail.com, marek.vasut@gmail.com, tiwai@suse.de,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	mark.fasheh@oracle.com, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org, dwmw2@infradead.org,
	dan.j.williams@intel.com, mchehab@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 16 Oct 2008, David Miller wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Date: Thu, 16 Oct 2008 09:31:29 +0200 (CEST)
> 
> > On Wed, 15 Oct 2008, David Miller wrote:
> > > > kernel/resource.c: In function '__reserve_region_with_split':
> > > > kernel/resource.c:554: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'resource_size_t'
> > > > kernel/resource.c:554: warning: format '%llx' expects type 'long long unsigned int', but argument 4 has type 'resource_size_t'
> > > > kernel/resource.c:554: warning: format '%llx' expects type 'long long unsigned int', but argument 6 has type 'resource_size_t'
> > > > kernel/resource.c:554: warning: format '%llx' expects type 'long long unsigned int', but argument 7 has type 'resource_size_t'
> > > 
> > > Known issue, Ben wants to add a new variant of %pX in order to print resources so that
> > > resource_size_t vs. unsigned long stuff doesn't matter like this any more.
> > 
> > Will still give a warning, as resource_size_t is not a pointer.
> 
> The idea is to pass in a pointer to the resource struct,
> and the %pX variant specified says what part to print.

Neat! So we can also have a separate variant to print the resource
range.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
