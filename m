Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: Add cpu family documentation
Date: Wed, 30 Apr 2014 20:33:49 +0200
Message-ID: <6387264.sEWrGGhGJ9@wuerfel>
In-Reply-To: <1398840308.5722.5.camel@concordia>
References: <1391229347-23026-1-git-send-email-mpe@ellerman.id.au>
 <1391553822.6733.189.camel@snotra.buserror.net>
 <1398840308.5722.5.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Scott Wood <scottwood@freescale.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 30 April 2014 16:45:08 Michael Ellerman wrote:
> > > +          v                                              v
> > > +   +--------------+                  +-------+   +----------------+
> > > +   |   POWER4+    | ---------------> |  970  |   |      7447      |
> > > +   +--------------+                  +-------+   +----------------+
> > > +          |                              |               |
> > > +          |                              |               |
> > > +          v                              v               v
> > > +   +--------------+     +-------+    +-------+   +----------------+
> > > +   |    POWER5    | --> | Cell  |    | 970FX |   |      7448      |
> > > +   +--------------+     +-------+    +-------+   +----------------+
> > > +          |                              |
> > > +          |                              |
> > > +          v                              v
> > > +   +--------------+                  +-------+
> > > +   |   POWER5+    |                  | 970MP |
> > > +   +--------------+                  +-------+
> > > +          |
> > > +          |
> > > +          v
> > > +   +--------------+
> > > +   |   POWER5++   |
> > > +   +--------------+
> > > +          |
> > > +          |
> > > +          v
> > > +   +--------------+
> > > +   |    POWER6    |
> > > +   +--------------+
> > > +          |
> > > +          |
> > > +          v

I think Cell and POWER6 are somewhat misrepresented here. Cell (together with
Xenon, which is the same core) is basically an independent development unrelated
to POWER5. POWER6 shares a lot of concepts with Cell, and IIRC is much closer
related to Cell than to POWER5, though I don't remember which one was designed
first. Probably code went both ways, and POWER6 got some enhancements that didn't
make it into the Cell PPU. They both contain VMX (Altivec) and have an in-order
pipeline.

POWER6 is also closely related to z10, while POWER7 then includes aspects of
both POWER5 and POWER6 but no longer shares much with z196, which in turn is
derived from z10.

	Arnd
