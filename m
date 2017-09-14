Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtQsY0x7KzDqZ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 03:45:04 +1000 (AEST)
Date: Thu, 14 Sep 2017 10:45:01 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Rob Landley <rob@landley.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 viro@zeniv.linux.org.uk, mingo@kernel.org,
 akpm@linux-foundation.org, keescook@chromium.org,
 tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
 mhocko@suse.com, viresh.kumar@linaro.org, tj@kernel.org,
 thomas.lendacky@amd.com, lauraa@codeaurora.org, lokeshvutla@ti.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] Make initramfs honor CONFIG_DEVTMPFS_MOUNT
Message-ID: <20170914174501.GA2129@kroah.com>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
 <8760gp9jjl.fsf@concordia.ellerman.id.au>
 <20170526072437.46499fbd@canb.auug.org.au>
 <87a7e82d-0af5-7f9e-6bd6-7e28b238e866@landley.net>
 <87r2z86ykt.fsf@concordia.ellerman.id.au>
 <4aa9cb26-f868-0720-e5c8-3c4e08afad20@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4aa9cb26-f868-0720-e5c8-3c4e08afad20@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 13, 2017 at 06:51:25PM -0500, Rob Landley wrote:
> From: Rob Landley <rob@landley.net>
> 
> Make initramfs honor CONFIG_DEVTMPFS_MOUNT, and move
> /dev/console open after devtmpfs mount.
> 
> Add workaround for Debian bug that was copied by Ubuntu.
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> ---
> 
> v2 discussion: http://lkml.iu.edu/hypermail/linux/kernel/1705.2/05611.html
> 
>  drivers/base/Kconfig |   14 ++++----------
>  fs/namespace.c       |   14 ++++++++++++++
>  init/main.c          |   15 +++++++++------
>  3 files changed, 27 insertions(+), 16 deletions(-)

Always run scripts/checkpatch.pl so you don't get grumpy emails from
reviewers telling you to run scripts/checkpatch.pl... telling you to run
scripts/checkpatch.pl... telling you to run scripts/checkpatch.pl...
telling you to run scripts/checkpatch.pl...
