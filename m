Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 36E6CDE14E
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 12:51:18 +1100 (EST)
Subject: Re: 2.6.28-rt on PowerPC
From: Steven Rostedt <srostedt@redhat.com>
To: frank.rowand@am.sony.com
In-Reply-To: <49823A13.50703@am.sony.com>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
	<1233270043.3833.57.camel@localhost.localdomain>
	<49823A13.50703@am.sony.com>
Content-Type: text/plain
Date: Thu, 29 Jan 2009 20:51:09 -0500
Message-Id: <1233280269.3833.60.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2009-01-29 at 15:21 -0800, Frank Rowand wrote:
> Steven Rostedt wrote:

> Your email can at an opportune time for me...  I was starting to try
> 2.6.28-rt on ARM and quickly came to the conclusion that the arch
> patches weren't the focus yet.  But I'm currently side-tracked with
> getting my board to even boot a vanilla 2.6.28 kernel first.  Do
> you expect to get to the arches in the next week or two?  If not,
> I may head down that path for ARM myself.

I'm going to try to apply the arch patches, but I do not have an arm
board myself. I do have a PPC64 box that works, but that's about it. I
have a powerbook too, but that box has never been able to boot an -rt
kernel. Who knows, maybe this one will boot.

I will create an rt/arm and an rt/ppc branch for the specific changes on
each. I'll try to get them next week (maybe tomorrow if things go better
than planned).

-- Steve
