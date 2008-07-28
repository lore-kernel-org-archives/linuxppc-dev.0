Return-Path: <ziomek@labs.mot.com>
Date: Mon, 28 Jul 2008 11:34:35 -0500
From: T Ziomek <ctz001@email.mot.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC,PATCH] scripts/package: add powerpc images to tarball
Message-ID: <20080728163435.GE27068@email.mot.com>
References: <1216887460.306306.238738123378.1.gpush@pingu>
	<200807250108.m6P18f4B099179@sullivan.realtime.net>
	<fa686aa40807252155l4f785920qdb14d117067b30f4@mail.gmail.com>
	<913573e2092839fbe37a0bfa37119eb6@bga.com>
	<fa686aa40807261053r5a8ebe40l7e8061f926f185f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40807261053r5a8ebe40l7e8061f926f185f9@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 26, 2008 at 01:53:57PM -0400, Grant Likely wrote:
 . . .
> Come to think of it, I'd support just removing the zImage symlink
> entirely to eliminate confusion so that everyone knows that 'make
> zImage' is the 'make all' for default image targets.

That ("zImage" means all default image targets) seems pretty non-intui-
tive; why not something like 'make all_def_images'?

Tom
-- 
  /"\  ASCII Ribbon Campaign   |
  \ /                          |   Email to user 'CTZ001'
   X        Against HTML       |             at 'email.mot.com'
  / \     in e-mail & news     |
