From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16004.15036.998922.996632@argo.ozlabs.ibm.com>
Date: Fri, 28 Mar 2003 23:06:20 +1100
To: Boris Bezlaj <boris@gajba.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5.66 compile fails under ppc32
In-Reply-To: <20030328111930.GA2451@gajba.net>
References: <20030328111930.GA2451@gajba.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Boris Bezlaj writes:

> did anyone encounter this problem when compiling 2.5.66 under ppc32 ?
>
> | include/linux/swapops.h: In function `pte_to_swp_entry':
> | include/linux/swapops.h:54: warning: implicit declaration of function `pte_file'
> | mm/fremap.c: In function `sys_remap_file_pages':
> | mm/fremap.c:139: `PTE_FILE_MAX_BITS' undeclared (first use in this function)

Linus just did a pull from my tree and so the definition is now in his
BK tree.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
