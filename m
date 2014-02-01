Return-Path: <mpe@ellerman.id.au>
Message-ID: <1391228931.15250.3.camel@concordia>
Subject: Re: [PATCH] powerpc: Add cpu family documentation
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sat, 01 Feb 2014 15:28:51 +1100
In-Reply-To: <20140130143237.a2bc71327ed4939cd71a734f@canb.auug.org.au>
References: <1391049480-29346-1-git-send-email-mpe@ellerman.id.au>
 <20140130143237.a2bc71327ed4939cd71a734f@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-30 at 14:32 +1100, Stephen Rothwell wrote:
> Hi Michael,
> 
> Nice.
> 
> On Thu, 30 Jan 2014 13:38:00 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > +++ b/Documentation/powerpc/cpu_families.txt
> > @@ -0,0 +1,76 @@
> > +CPU Families
> > +============
> > +
> > +This doco tries to summarise some of the different cpu families that exist and
>         ^^^^
> document
> 
> > +   |            |
> > +   |            *---- [620] --- POWER3/630 --- POWER3+ --- POWER4 --- POWER4+ --- POWER5 --- POWER5+ --- POWER5++ --- POWER6 --- POWER7 --- POWER7+ --- POWER8
> 
> Its a pity that this wraps ...

Yeah it is. I was too lazy to fix it.

New version coming.

cheers
