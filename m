Return-Path: <kilobyte@angband.pl>
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2a03:9300:10::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj8V66q2GzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 01:26:06 +1000 (AEST)
Date: Wed, 30 Aug 2017 16:57:42 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Jerome Glisse <jglisse@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Bernhard Held <berny156@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Sudeep Dutt <sudeep.dutt@intel.com>,
 Ashutosh Dixit <ashutosh.dixit@intel.com>,
 Dimitri Sivanich <sivanich@sgi.com>, Jack Steiner <steiner@sgi.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 DRI <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
 xen-devel <xen-devel@lists.xenproject.org>, KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH 00/13] mmu_notifier kill invalidate_page callback
Message-ID: <20170830145742.xird3lgsb3nemtye@angband.pl>
References: <20170829235447.10050-1-jglisse@redhat.com>
 <CA+55aFz6ArJ-ADXiYCu6xMUzdY=mKBtkzfJmLaBohC6Ub9t2SQ@mail.gmail.com>
 <20170830005615.GA2386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170830005615.GA2386@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 29, 2017 at 08:56:15PM -0400, Jerome Glisse wrote:
> I will wait for people to test and for result of my own test before
> reposting if need be, otherwise i will post as separate patch.
>
> > But from a _very_ quick read-through this looks fine. But it obviously
> > needs testing.
> > 
> > People - *especially* the people who saw issues under KVM - can you
> > try out Jérôme's patch-series? I aded some people to the cc, the full
> > series is on lkml. Jérôme - do you have a git branch for people to
> > test that they could easily pull and try out?
> 
> https://cgit.freedesktop.org/~glisse/linux mmu-notifier branch
> git://people.freedesktop.org/~glisse/linux

Tested your branch as of 10f07641, on a long list of guest VMs.
No earth-shattering kaboom.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ Vat kind uf sufficiently advanced technology iz dis!?
⢿⡄⠘⠷⠚⠋⠀                                 -- Genghis Ht'rok'din
⠈⠳⣄⠀⠀⠀⠀ 
