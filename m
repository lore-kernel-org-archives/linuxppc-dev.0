Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A5B87DE1DB
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 09:17:31 +1000 (EST)
Date: Thu, 24 Jul 2008 19:17:33 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: section .dummy lma 0xc0294310 overlaps previous sections
Message-ID: <20080724191733.27dc4eb8@lappy.seanm.ca>
In-Reply-To: <c7d136a69bb02682bf5f3dbbd658d975@kernel.crashing.org>
References: <20080724001857.42fc7e09@lappy.seanm.ca>
	<c7d136a69bb02682bf5f3dbbd658d975@kernel.crashing.org>
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

On Fri, 25 Jul 2008 00:29:28 +0200
"Segher Boessenkool" <segher@kernel.crashing.org> wrote:

> > Anybody else seeing these? With Linus' latest I get three of these
> > warnings: .tmp_vmlinux1, .tmp_vmlinux2, and vmlinux.
> 
> Ah, that's useful information, I think I know what's going on
> now.  What was your binutils version?

2.16.1. Comes from the Denx 4.1 ELDK if that helps any.

Cheers,
   Sean
