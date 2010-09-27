Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] 476: Set CCR2[DSTI] to prevent isync from flushing
	shadow TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
In-Reply-To: <1285601205.17411.23.camel@shaggy-w500>
References: <1285351297-9999-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1285351297-9999-2-git-send-email-shaggy@linux.vnet.ibm.com>
	<20100927150434.GA2888@zod.rchland.ibm.com>
	<1285601205.17411.23.camel@shaggy-w500>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Sep 2010 07:10:52 +1000
Message-ID: <1285621852.14081.62.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-09-27 at 10:26 -0500, Dave Kleikamp wrote:
> I think I made it a config option at Ben's request when I first started
> this work last year, before being sidetracked by other priorities.  I
> could either remove the option, or default it to 'n'.  It might be best
> to just hard-code the behavior to make sure it's exercised, since
> there's no 47x hardware in production yet, but we can give Ben a chance
> to weigh in with his opinion.

You can remove the option I suppose. It was useful to have it during
early bringup but probably not anymore.

Cheers,
Ben.
