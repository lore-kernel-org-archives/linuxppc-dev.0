Date: Tue, 25 May 2004 10:23:52 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: curious about BK checkin protocol
Message-ID: <20040525102352.A1329@home.com>
References: <Pine.LNX.4.58.0405250909280.14496@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0405250909280.14496@localhost.localdomain>; from rpjday@mindspring.com on Tue, May 25, 2004 at 09:12:10AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 25, 2004 at 09:12:10AM -0400, Robert P. J. Day wrote:
>
>   i just bk-cloned a fresh copy of the source tree from
> http://ppc.bkbits.net:8080/linuxppc-2.5, and once again, had to fix the
> file arch/ppc/kernel/ppc_ksyms.c to remove the now-obsolete snippet of
> code:
>
> #if defined(CONFIG_8xx)
> EXPORT_SYMBOL(request_8xxirq);
> #endif
>
>   i thought it had been well-established by now that this had to go.
> what's the protocol for someone putting these changes into the tree?
> just curious.

Post a patch.  If it's something that is incorrect in linux-2.5
as well, then the patch is expected to be against linux-2.5.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
