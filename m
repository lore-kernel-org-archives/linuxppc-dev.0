Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8W3m5QCzzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:41:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernv: Fix crash in gpstate_timer_handler
In-Reply-To: <9902339.J95Mxqndi6@vostro.rjw.lan>
References: <1470324557-20711-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160804164711.GE10348@ubuntu> <87oa51tfgg.fsf@concordia.ellerman.id.au>
 <9902339.J95Mxqndi6@vostro.rjw.lan>
Date: Wed, 10 Aug 2016 22:41:21 +1000
Message-ID: <87mvkkssni.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> On Wednesday, August 10, 2016 02:28:47 PM Michael Ellerman wrote:
>> 
>> Who's merging this?
>
> I am.

Thanks!
