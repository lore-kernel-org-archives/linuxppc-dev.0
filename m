Return-Path: <anton@samba.org>
Date: Thu, 27 Mar 2014 14:56:04 +1100
From: Anton Blanchard <anton@samba.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Message-ID: <20140327145604.539b871d@kryten>
In-Reply-To: <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@ozlabs.org,
 srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Gautham,

> Backend driver to dynamically set voltage and frequency on
> IBM POWER non-virtualized platforms.  Power management SPRs
> are used to set the required PState.

I tested this version on ppc64le, it still looks good. I'm already
a Signed-off-by on the patch, but feel free to add:

Tested-by: Anton Blanchard <anton@samba.org>

Anton
