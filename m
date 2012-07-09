Return-Path: <cl@linux.com>
Received: from smtp108.prem.mail.ac4.yahoo.com
 (smtp108.prem.mail.ac4.yahoo.com [76.13.13.47])
 by ozlabs.org (Postfix) with SMTP id 0F0712C0203
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 01:19:00 +1000 (EST)
Date: Mon, 9 Jul 2012 10:18:54 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH v3 0/13] memory-hotplug : hot-remove physical
 memory
In-Reply-To: <4FFAB0A2.8070304@jp.fujitsu.com>
Message-ID: <alpine.DEB.2.00.1207091015570.30060@router.home>
References: <4FFAB0A2.8070304@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: len.brown@intel.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 9 Jul 2012, Yasuaki Ishimatsu wrote:

> Even if you apply these patches, you cannot remove the physical memory
> completely since these patches are still under development. I want you to
> cooperate to improve the physical memory hot-remove. So please review these
> patches and give your comment/idea.

Could you at least give a method on how you want to do physical memory
removal? You would have to remove all objects from the range you want to
physically remove. That is only possible under special circumstances and
with a limited set of objects. Even if you exclusively use ZONE_MOVEABLE
you still may get cases where pages are pinned for a long time.

I am not sure that these patches are useful unless we know where you are
going with this. If we end up with a situation where we still cannot
remove physical memory then this patchset is not helpful.
