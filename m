Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.181])
	by ozlabs.org (Postfix) with ESMTP id 0AEE2DE120
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 12:46:43 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: <20090125194853.GB26917@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090125194853.GB26917@pengutronix.de>
Date: Sun, 25 Jan 2009 18:46:41 -0700
Message-ID: <fa686aa40901251746x644e22c6tf8862103c04db1dc@mail.gmail.com>
Subject: Re: [PATCH 1/8] powerpc/5200: update device tree binding
	documentation
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devtree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 25, 2009 at 12:48 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Wed, Jan 21, 2009 at 01:55:07PM -0700, Grant Likely wrote:
>> +system-frequency     Fsystem frequency; source of all
>
> Fsystem? Typo?

Not really, that's the name of the clock in the MP5200 user guide.
I'll clarify what I've written here though.

> The unit would be nice here, too, I think.

Unit?  Do you mean stating that it is in Hz?

>> +cdm@<addr>                   fsl,mpc5200-cmd         Clock Distribution
>
>                                             ^^ cdm!

>> +is for flags which is currently unsused.
>
> Typo: should be "unused".

Good catches, thanks.

g.
