Return-Path: <vasilis.liaskovitis@profitbricks.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37A2C2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 23:52:20 +1000 (EST)
Received: by eeke50 with SMTP id e50so956605eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 06:52:17 -0700 (PDT)
Date: Mon, 10 Sep 2012 15:52:13 +0200
From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC v8 PATCH 00/20] memory-hotplug: hot-remove physical memory
Message-ID: <20120910135213.GA1550@dhcp-192-168-178-175.profitbricks.localdomain>
References: <1346148027-24468-1-git-send-email-wency@cn.fujitsu.com>
 <20120831134956.fec0f681.akpm@linux-foundation.org>
 <504D467D.2080201@jp.fujitsu.com> <504D4A08.7090602@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <504D4A08.7090602@cn.fujitsu.com>
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, cl@linux.com, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Sep 10, 2012 at 10:01:44AM +0800, Wen Congyang wrote:
> At 09/10/2012 09:46 AM, Yasuaki Ishimatsu Wrote:
> > Hi Wen,
> > 
> > 2012/09/01 5:49, Andrew Morton wrote:
> >> On Tue, 28 Aug 2012 18:00:07 +0800
> >> wency@cn.fujitsu.com wrote:
> >>
> >>> This patch series aims to support physical memory hot-remove.
> >>
> >> I doubt if many people have hardware which permits physical memory
> >> removal?  How would you suggest that people with regular hardware can
> >> test these chagnes?
> > 
> > How do you test the patch? As Andrew says, for hot-removing memory,
> > we need a particular hardware. I think so too. So many people may want
> > to know how to test the patch.
> > If we apply following patch to kvm guest, can we hot-remove memory on
> > kvm guest?
> > 
> > http://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01389.html
> 
> Yes, if we apply this patchset, we can test hot-remove memory on kvm guest.
> But that patchset doesn't implement _PS3, so there is some restriction.

the following repos contain the patchset above, plus 2 more patches that add
PS3 support to the dimm devices in qemu/seabios:

https://github.com/vliaskov/seabios/commits/memhp-v2
https://github.com/vliaskov/qemu-kvm/commits/memhp-v2

I have not posted the PS3 patches yet in the qemu list, but will post them
soon for v3 of the memory hotplug series. If you have issues testing, let me
know.

thanks,

- Vasilis
