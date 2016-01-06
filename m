Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 604BB1A1176
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 17:52:16 +1100 (AEDT)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A02271402C4
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2016 17:52:15 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 5 Jan 2016 23:52:13 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E6CCB19D803E
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jan 2016 23:40:12 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u066qANr28639344
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jan 2016 23:52:10 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u066qAxp020409
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jan 2016 23:52:10 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, pc@us.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 0/2] cpufreq: powernv: Redesign the presentation of
 throttle notification
In-Reply-To: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Wed, 06 Jan 2016 17:51:57 +1100
Message-ID: <877fjnjj3m.fsf@linux.vnet.ibm.com>
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

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
> CPU when the chip crosses its thermal and power limits. Currently,
> powernv-cpufreq driver detects and reports this event as a console
> message. Some boxes may not sustain the max turbo frequency in all
> conditions and can be throttled frequently. This can lead to the
> flooding of console with throttle messages. So this patchset aims to
> redesign the presentation of this event via sysfs counters and
> tracepoints.

This likely should CC stable@ as we have seen this on some machines, at
least in the lab.

-- 
Stewart Smith
OPAL Architect, IBM.
