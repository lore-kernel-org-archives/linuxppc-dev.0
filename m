Return-Path: <geoff@infradead.org>
Message-ID: <1421173988.10001.32.camel@smoke>
Subject: Re: [PATCH 3/6] powerpc/ps3: Write highmem info to repository
From: Geoff Levand <geoff@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 13 Jan 2015 10:33:08 -0800
In-Reply-To: <1421118298.26626.2.camel@ellerman.id.au>
References: <cover.1421109719.git.geoff@infradead.org>
 <3deced9919246f281e48f1258885937f11a4b4ee.1421109719.git.geoff@infradead.org>
 <1421118298.26626.2.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 Hector Martin <hector@marcansoft.com>,
 Nathan Whitehorn <nwhitehorn@freebsd.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, 2015-01-13 at 14:04 +1100, Michael Ellerman wrote:
> On Tue, 2015-01-13 at 01:00 +0000, Geoff Levand wrote:
> > Add calls to the ps3_mm_set_repository_highmem() routine when the ps3
> > r1 highmem region is either created or destroyed.
> 
> What does this actually do? ie. from a user perspective.

It will allow a kexec based bootloader (petitboot for example) to
pre-allocate a highmem region and store things like an initrd or other
large data needed to boot an OS.  With some PS3 configurations the boot
memory region is not large enough to fit all the boot data.

There was ongoing discussion about this on the ML.  Here are two
relevant posts:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-April/097691.html
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-April/097695.html

Here is the very first post which outlines the motivation, etc.:

https://lists.ozlabs.org/pipermail/cbe-oss-dev/2011-August/007420.html

-Geoff
