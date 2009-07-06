Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B884BB6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jul 2009 16:56:43 +1000 (EST)
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 4E223DDD01
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2009 16:56:42 +1000 (EST)
Date: Mon, 6 Jul 2009 08:56:27 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Inline assembly queries [2]
Message-ID: <20090706065627.GA12499@iram.es>
References: <abe8a1fd0907022344k2eb9874ejdbda3209a7cadf40@mail.gmail.com>
	<20090703174031.GA12410@cynthia.pants.nu>
	<m23a9deb87.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m23a9deb87.fsf@igel.home>
Cc: gcc-help@gcc.gnu.org, kernel mailz <kernelmailz@googlemail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 03, 2009 at 10:57:12PM +0200, Andreas Schwab wrote:
> Brad Boyer <flar@allandria.com> writes:
> 
> > On Fri, Jul 03, 2009 at 12:14:41PM +0530, kernel mailz wrote:
> >> b. using m or Z  with a memory address. I tried replacing m/Z but no change
> >> Is there some guideline ?
> >> gcc documentation says Z is obsolete. Is m/Z replaceable ?
> >
> > No idea. I don't remember ever seeing 'Z' used in anything. Maybe somebody
> > else remembers what it used to mean.
> 
> The 'Z' constraint is required for a memory operand for insns that don't
> have an update form (which would be selected by the %U modifier).  

Hmmm, I believed that it was for instructions that only have an indexed
form (all Altivec, byte reverse, and l?arx/st?cx for atomic operations).

Of course none of these instructions have an update form, but they don't
have an offset encoded in the instruction either.

	Gabriel
