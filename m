Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 29D011A0784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 04:37:27 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V4] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
Date: Tue, 17 Feb 2015 18:53:59 +0100
Message-ID: <4031451.QMQakQrpsN@vostro.rjw.lan>
In-Reply-To: <54E2F4CE.2090205@linux.vnet.ibm.com>
References: <20150203061709.13097.7035.stgit@preeti.in.ibm.com>
 <54E2F4CE.2090205@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, February 17, 2015 01:29:10 PM Preeti U Murthy wrote:
> Hi Rafael,

Hi,

> Can you please pull this patch ?

Sorry, I wasn't sure whether or not the patch was for me to take and then
I've been traveling lately.  Applied now.

> Another patch based on top of this is waiting to be pulled:
> [PATCH] driver/cpuidle-powernv: Avoid endianness conversions while parsing DT

OK, have you posted it already?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
