Return-Path: <toshi.kani@hp.com>
Received: from g1t0027.austin.hp.com (g1t0027.austin.hp.com [15.216.28.34])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4607D2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Aug 2013 00:35:09 +1000 (EST)
Message-ID: <1377873212.10300.877.camel@misato.fc.hp.com>
Subject: Re: [PATCH v2 0/4] Unify CPU hotplug lock interface
From: Toshi Kani <toshi.kani@hp.com>
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Date: Fri, 30 Aug 2013 08:33:32 -0600
In-Reply-To: <522006F6.2060206@jp.fujitsu.com>
References: <1377822129-4143-1-git-send-email-toshi.kani@hp.com>
 <522006F6.2060206@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fenghua.yu@intel.com, bp@suse.de, gregkh@linuxfoundation.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl,
 linux-acpi@vger.kernel.org, mingo@redhat.com, srivatsa.bhat@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, tglx@linutronix.de, hpa@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-30 at 11:44 +0900, Yasuaki Ishimatsu wrote:
> (2013/08/30 9:22), Toshi Kani wrote:
> > lock_device_hotplug() was recently introduced to serialize CPU & Memory
> > online/offline and hotplug operations, along with sysfs online interface
> > restructure (commit 4f3549d7).  With this new locking scheme,
> > cpu_hotplug_driver_lock() is redundant and is no longer necessary.
> > 
> > This patchset makes sure that lock_device_hotplug() covers all CPU online/
> > offline interfaces, and then removes cpu_hotplug_driver_lock().
> > 
> > v2:
> >   - Rebased to the pm tree, bleeding-edge.
> >   - Changed patch 2/4 to use lock_device_hotplug_sysfs().
> > 
> > ---
> > Toshi Kani (4):
> >    hotplug, x86: Fix online state in cpu0 debug interface
> >    hotplug, x86: Add hotplug lock to missing places
> >    hotplug, x86: Disable ARCH_CPU_PROBE_RELEASE on x86
> >    hotplug, powerpc, x86: Remove cpu_hotplug_driver_lock()
> > 
> > ---
> The patch-set looks good to me.
> 
> Acked-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks Yasuaki!
-Toshi
