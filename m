Message-ID: <XFMail.20040512095756.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <16545.27647.651552.393992@cargo.ozlabs.ibm.com>
Date: Wed, 12 May 2004 09:57:56 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
Cc: linuxppc-dev@lists.linuxppc.org, Amit Shah <amitshah@gmx.net>,
	Dan Malek <dan@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 12-May-2004 Paul Mackerras wrote:
>
> The only workaround I can see for this is to completely flush the D
> and I caches of both CPUs whenever we schedule a process on a
> different CPU from that on which it last ran.  Triple yuck.

It's not very different than what Linux does with NUMA
systems AFAIK. If some cache management instructions cause
troubles and it is an embedded system, it may be a good
solution recompiling user space stuff removing problematic
parts.



--
Giuliano.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
