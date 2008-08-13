Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18594.27882.356281.234216@cargo.ozlabs.ibm.com>
Date: Wed, 13 Aug 2008 15:11:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: mohan@in.ibm.com
Subject: Re: [PATCH 3/5] Apply relocation
In-Reply-To: <20080812081028.GC19619@in.ibm.com>
References: <20080811201120.GA25283@in.ibm.com>
	<20080811201547.GC26566@in.ibm.com>
	<20080812081028.GC19619@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M writes:

> This code is a wrapper around regular kernel. This checks whether the
> kernel is loaded at 32MB, if its not loaded at 32MB, its treated as a
> regular kernel and the control is given to the kernel immediately. If
> the kernel is loaded at 32MB, it applies relocation delta to each offset
> in the list which was generated and appended by patch 1 and 2. After
> updating all offsets, control is given to the relocatable kernel.

In patch 1, you output the addresses for three kinds of relocations,
but here you only seem to handle two (R_PPC64_ADDR64 and
R_PPC64_ADDR16_HI, I assume).  How does that work?

In general with this patch series, I would like to have seen much more
detailed patch descriptions.  I think most of these patches could have
used 4 or 5 paragraphs of description (or more if you like) telling us
things such as why you handle the particular relocations you do and
not others.

Paul.
