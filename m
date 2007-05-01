Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17975.12087.73762.795635@cargo.ozlabs.ibm.com>
Date: Tue, 1 May 2007 22:14:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powermac: proper sleep management
In-Reply-To: <1177934887.5102.65.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
	<17971.14223.435220.418649@cargo.ozlabs.ibm.com>
	<1177767996.5102.9.camel@johannes.berg>
	<17973.32577.253554.707441@cargo.ozlabs.ibm.com>
	<1177934887.5102.65.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> I disagree with that, it'll get us no closer to keeping the generic code
> working for us. It does in fact work now, I've been using it for a long
> time and a few other people have also tried on older powerbooks. It's
> also very hard to convince anybody that we need changes in the generic
> code if at the same time we do our own stuff because "the generic code
> (you wrote) is not good enough for us anyway."

I think that once we have /sys/power/state working the distros will
start using it.  I want the old way to keep doing what it was doing
while the new way is tested and the bugs are shaken out.

Bottom line is I'm not going to apply a patch that makes pmu_ioctl
call pm_suspend.

Paul.
