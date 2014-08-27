Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E8731A003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 10:34:06 +1000 (EST)
Message-ID: <1409099608.21254.16.camel@smoke>
Subject: Re: [PATCH 0/5] kexec: minor fixups and enhancements
From: Geoff Levand <geoff@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Date: Tue, 26 Aug 2014 17:33:28 -0700
In-Reply-To: <20140825165916.GC14379@redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <20140825165916.GC14379@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

Hi Vivek,

On Mon, 2014-08-25 at 12:59 -0400, Vivek Goyal wrote:
> Does arm64 has secureboot? If yes, then it might make sense to
> enable the new syscall kexec_file_load() on arm64 instead of trying
> to make old syscall work first.

Yes, arm64 should support secureboot, but I have not looked into it.

When do you expect syscall kexec_file_load to get merged?  I won't wait
until then to push my current kexec work.

-Geoff
