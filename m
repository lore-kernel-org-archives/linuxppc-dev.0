Return-Path: <david@fromorbit.com>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 3z0wGC0VkCzDqgv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 09:10:42 +1100 (AEDT)
Date: Tue, 19 Dec 2017 09:10:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-xfs@vger.kernel.org, linux-audit@redhat.com,
 alsa-devel@alsa-project.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [trivial PATCH] treewide: Align function definition open/close
 braces
Message-ID: <20171218221040.GG4094@dastard>
References: <1513556924.31581.51.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513556924.31581.51.camel@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 17, 2017 at 04:28:44PM -0800, Joe Perches wrote:
> Some functions definitions have either the initial open brace and/or
> the closing brace outside of column 1.
> 
> Move those braces to column 1.
> 
> This allows various function analyzers like gnu complexity to work
> properly for these modified functions.
> 
> Miscellanea:
> 
> o Remove extra trailing ; and blank line from xfs_agf_verify
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
....

XFS bits look fine.

Acked-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
