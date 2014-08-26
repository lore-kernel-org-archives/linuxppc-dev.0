Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC83B1A0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 17:41:08 +1000 (EST)
Date: Tue, 26 Aug 2014 15:41:43 +0800
From: Dave Young <dyoung@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/5] kexec: minor fixups and enhancements
Message-ID: <20140826074143.GG11693@darkstar.nay.redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <20140825165916.GC14379@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140825165916.GC14379@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/25/14 at 12:59pm, Vivek Goyal wrote:
> On Fri, Aug 22, 2014 at 06:39:47PM +0000, Geoff Levand wrote:
> > Hi,
> > 
> > Here are a few minor fixups and enhancements for kexec support. 
> > 
> > Patch 3 and 4 that add preprocessor macros for the kimage list flags are
> > ones that I use in the arm64 kexec support I am working on, so it would
> > be nice for those to go in.
> > 
> > Please consider.
> 
> Hi Geoff,
> 
> Does arm64 has secureboot? If yes, then it might make sense to
> enable the new syscall kexec_file_load() on arm64 instead of trying
> to make old syscall work first.

It will save efforts for efi support as well, for the in-kernel loader we do not
necessary to save the efi physical addresses or runtime ranges to sysfs and
passing them to 2nd kernel, we can just copy them in kernel.

Thanks
Dave
