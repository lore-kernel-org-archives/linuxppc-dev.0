Return-Path: <deller@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybHRz0y9RzDqhL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:19:10 +1100 (AEDT)
Subject: Re: [PATCHv4 0/6] printk/ia64/ppc64/parisc64: let's deprecate %pF/%pf
 printk specifiers
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <f7ba9e1c-10d8-3519-faad-7520c450c3e9@gmx.de>
Date: Mon, 13 Nov 2017 18:17:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10.11.2017 00:48, Sergey Senozhatsky wrote:
> 	All Ack-s/Tested-by-s were dropped, since the patch set has been
> reworked. I'm kindly asking arch-s maintainers and developers to test it
> once again. Sorry for any inconveniences and thanks for your help in
> advance.

I tested it successfully on parisc64.
You can add back the
Tested-by: Helge Deller <deller@gmx.de> #parisc64

Thanks!
Helge
