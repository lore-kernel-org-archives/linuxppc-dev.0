Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 3A9C6DDF0B
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 09:43:46 +1000 (EST)
Date: Thu, 24 Jul 2008 19:43:48 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: section .dummy lma 0xc0294310 overlaps previous sections
Message-ID: <20080724194348.2656412e@lappy.seanm.ca>
In-Reply-To: <20080724191733.27dc4eb8@lappy.seanm.ca>
References: <20080724001857.42fc7e09@lappy.seanm.ca>
	<c7d136a69bb02682bf5f3dbbd658d975@kernel.crashing.org>
	<20080724191733.27dc4eb8@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jul 2008 19:17:33 -0400
"Sean MacLennan" <sean.maclennan@ottawa.kanatek.ca> wrote:

> On Fri, 25 Jul 2008 00:29:28 +0200
> "Segher Boessenkool" <segher@kernel.crashing.org> wrote:
> 
> > > Anybody else seeing these? With Linus' latest I get three of these
> > > warnings: .tmp_vmlinux1, .tmp_vmlinux2, and vmlinux.
> > 
> > Ah, that's useful information, I think I know what's going on
> > now.  What was your binutils version?
> 
> 2.16.1. Comes from the Denx 4.1 ELDK if that helps any.

If I back out c69cccc95fe4b90dde5fe33e6a3b77880b534fa4 "Fix build bug
with binutils < 2.18 and GCC < 4.2" then the warnings go away.

And yes, the compiler is GCC 4.0.

Cheers,
   Sean
