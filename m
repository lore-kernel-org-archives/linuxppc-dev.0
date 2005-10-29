Return-Path: <galak@gate.crashing.org>
Date: Sat, 29 Oct 2005 07:55:32 -0500 (CDT)
From: galak@gate.crashing.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20051029180755.22de749b.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0510290754300.19149-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	linuxppc64-dev@ozlabs.org
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 29 Oct 2005, Stephen Rothwell wrote:

> On Fri, 28 Oct 2005 13:49:26 -0500 Kumar Gala <kumar.gala@freescale.com> wrote:
> >
> > Can you merge this in:
> > 
> > http://patchwork.ozlabs.org/linuxppc/patch?id=2931
> 
> I can't find any use of mpc85xx_show_cpuinfo.  Is there something subtle here?

No, you are correct.  This was a bogus decleration before.  I will kill 
it and resend the patch.

- kumar
