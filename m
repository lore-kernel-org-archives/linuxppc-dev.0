Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id B6823DDFCC
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 02:47:36 +1100 (EST)
Date: Thu, 11 Dec 2008 15:31:59 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Timur Tabi <timur@freescale.com>
Subject: Re: MPC8610HPCD sound as module
Message-ID: <20081211153158.GF30808@sirena.org.uk>
References: <49411308.1050008@fang.fa.gau.hu>
	<ed82fe3e0812110712r4baeea60ied52937aa434f48e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0812110712r4baeea60ied52937aa434f48e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 09:12:54AM -0600, Timur Tabi wrote:
> On Thu, Dec 11, 2008 at 7:18 AM, Peter Czanik <pczanik@fang.fa.gau.hu> wrote:

> > As far as I can see from comments in the sources, it should work also as
> > a module. Any hints how to achieve that?

> The ASoC V2 version of the driver supports loading as a module.  ASoC
> V1 does not support loading sound drivers as modules, which is why I
> didn't implement that support in the V1 drivers.  The 2.6.27 kernel

ASoC v1 supports loading drivers as modules (and this is fairly heavily
used), though as you say the MPC8610 drivers don't support that.

> has ASoC V1.  ASoC V2 won't be integrated into the mainline until at
> least 2.6.29, and maybe even 2.6.30.  The ASoC V2 repository is
> available at http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git
> under the asoc-v2-dev branch.

At the minute there's code queued for merge which defers card
instantiation until DAIs and platforms have registered, allowing the
various parts of the system to probe through the normal mechanisms.
That's the most substantial of the outstanding changes.
