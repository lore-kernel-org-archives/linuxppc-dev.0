Return-Path: <anton@samba.org>
Date: Wed, 9 Oct 2013 10:56:19 +1100
From: Anton Blanchard <anton@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/powernv: Reduce panic timeout from 180s to 10s
Message-ID: <20131009105619.1189c050@kryten>
In-Reply-To: <1381269153.7979.281.camel@snotra.buserror.net>
References: <20130926211719.7b99740a@kryten> <20131001083918.GD27484@concordia>
 <1381269153.7979.281.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > > We made this change to pseries in 2011 and I think it makes
> > > sense to do the same on powernv.
> > 
> > I'd vote we set it to 10s for all 64-bit machines in
> > arch/powerpc/kernel/setup_64.c.
> 
> Why is 64-bit relevant?  And wouldn't such a short delay be a problem
> if the crash is displayed on a monitor?

That is why we made it pseries specific in the past. Almost all our
boxes are on a virtual console and the 3 minutes of pausing just hurt
our uptimes.

If other platform maintainers prefer to keep the 3 minute pause, then
we just change the PowerNV platform.

Anton
