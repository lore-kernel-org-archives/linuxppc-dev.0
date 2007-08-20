Return-Path: <jonli447@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 97DCCDDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:05:52 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so840510nfd
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 10:05:50 -0700 (PDT)
Message-ID: <9050bda20708201005n1e08ed17gfbffc3d4ffab62bd@mail.gmail.com>
Date: Mon, 20 Aug 2007 12:05:49 -0500
From: "Jonathan Li" <jonli447@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: LINKSTATION default config update for linux-2.6.23-rc3
In-Reply-To: <e034e26666986dc56279ab552d80fbe7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9050bda20708191111n497e1565h87eb9a2423a6ba56@mail.gmail.com>
	<e034e26666986dc56279ab552d80fbe7@kernel.crashing.org>
Cc: g.liakhovetski@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Disregard

You are correct, they are not used.  For some reason, I had a config
with it (I also work on an arm box which does use it :-) )

On 8/19/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > Please update the default config in linux-2.6.23 for the LINKSTATION
> > board with the following changes:
> >
> > SK98LIN SysKonnect driver is deprecated.  Use SKGE instead.
>
> /me confused...
>
> None of SK98LIN, SKGE, SKY2 are in the linkstation_defconfig --
> not unsurprisingly, since the hardware doesn't contain any such
> chip.
>
>
> Segher
>
>
