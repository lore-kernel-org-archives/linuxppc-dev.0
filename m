Return-Path: <avorontsov@ru.mvista.com>
Date: Fri, 11 Jul 2008 22:45:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] Convert i2c-mpc from a platform driver into a
	of_platform driver, V4
Message-ID: <20080711184556.GA14368@polina.dev.rtsoft.ru>
References: <20080630230126.12482.87927.stgit@terra>
	<fa686aa40807091022q22f6be99j89f311780bd3d369@mail.gmail.com>
	<8EAD138A-6CE4-4AC7-BCBF-13B8E7C24CF1@freescale.com>
	<20080711181214.GA15321@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080711181214.GA15321@secretlab.ca>
Cc: Linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	i2c@lm-sensors.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 11, 2008 at 12:12:14PM -0600, Grant Likely wrote:
> On Thu, Jul 10, 2008 at 12:36:58PM -0400, Timur Tabi wrote:
> >
> > On Jul 9, 2008, at 1:22 PM, Grant Likely wrote:
> >
> >> On Mon, Jun 30, 2008 at 5:01 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> >>> Convert i2c-mpc to an of_platform driver. Utilize the code in  
> >>> drivers/of-i2c.c to make i2c modules dynamically loadable by the  
> >>> device tree.
> >>
> >> Timur, can you please test this one on an 83xx platform?  It works on
> >> 5200, but I want to make sure 83xx doesn't break before I pick it up.
> >
> > I'm on vacation this week, so I'll have to deal with it next week, after 
> > I've handled higher-priority issues.
> 
> Kumar, is there anyone else who can test this out before the merge
> window opens?

FWIW, they seem to work for me. At least RTC still works.


p.s. [1/2] conflicts with fsl_soc.c. And these patches will
conflict a bit more (now with of_i2c.c), if/when
"[PATCH] of/i2c: don't pass -1 to irq_dispose_mapping, otherwise kernel
kernel will oops"

will be applied to 2.6.26.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
