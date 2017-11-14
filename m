Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybVKq6BXSzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 12:29:35 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id b6so12937755pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 17:29:35 -0800 (PST)
Date: Tue, 14 Nov 2017 10:29:27 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv4 0/6] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Message-ID: <20171114012927.GB7328@jagdpanzerIV>
References: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
 <f7ba9e1c-10d8-3519-faad-7520c450c3e9@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f7ba9e1c-10d8-3519-faad-7520c450c3e9@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (11/13/17 18:17), Helge Deller wrote:
> On 10.11.2017 00:48, Sergey Senozhatsky wrote:
> > 	All Ack-s/Tested-by-s were dropped, since the patch set has been
> > reworked. I'm kindly asking arch-s maintainers and developers to test it
> > once again. Sorry for any inconveniences and thanks for your help in
> > advance.
> 
> I tested it successfully on parisc64.
> You can add back the
> Tested-by: Helge Deller <deller@gmx.de> #parisc64

thanks!

	-ss
