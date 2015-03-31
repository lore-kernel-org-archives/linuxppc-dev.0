Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0089.hostedemail.com
 [216.40.44.89])
 by lists.ozlabs.org (Postfix) with ESMTP id A94E91A0272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 11:14:57 +1100 (AEDT)
Message-ID: <1427760888.14276.37.camel@perches.com>
Subject: Re: [PATCH 00/25] treewide: Use bool function return values of
 true/false not 1/0
From: Joe Perches <joe@perches.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Date: Mon, 30 Mar 2015 17:14:48 -0700
In-Reply-To: <5519E53B.5040504@schaufler-ca.com>
References: <cover.1427759009.git.joe@perches.com>
 <5519E53B.5040504@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
 patches@opensource.wolfsonmicro.com, linux-ia64@vger.kernel.org,
 kvm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-hexagon@vger.kernel.org, bridge@lists.linux-foundation.org,
 coreteam@netfilter.org, linux-pm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-ide@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netfilter-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-30 at 17:07 -0700, Casey Schaufler wrote:
> On 3/30/2015 4:45 PM, Joe Perches wrote:
> > Joe Perches (25):
> >   arm: Use bool function return values of true/false not 1/0

[etc...]

> Why, and why these in particular?

bool functions are probably better returning
bool values instead of 1 and 0.

Especially when the functions intermix returning
returning 1/0 and true/false.

(there are only a couple of those though)

These are all the remaining instances in the
kernel tree.
