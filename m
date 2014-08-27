Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C23D1A003D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 10:43:32 +1000 (EST)
Date: Tue, 26 Aug 2014 20:42:41 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 0/5] kexec: minor fixups and enhancements
Message-ID: <20140827004241.GA25728@redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <20140825165916.GC14379@redhat.com>
 <1409099608.21254.16.camel@smoke>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409099608.21254.16.camel@smoke>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 26, 2014 at 05:33:28PM -0700, Geoff Levand wrote:
> Hi Vivek,
> 
> On Mon, 2014-08-25 at 12:59 -0400, Vivek Goyal wrote:
> > Does arm64 has secureboot? If yes, then it might make sense to
> > enable the new syscall kexec_file_load() on arm64 instead of trying
> > to make old syscall work first.
> 
> Yes, arm64 should support secureboot, but I have not looked into it.
> 
> When do you expect syscall kexec_file_load to get merged?  I won't wait
> until then to push my current kexec work.

It got merged in 3.17-rc1

Thanks
Vivek
