Date: Thu, 12 Apr 2001 16:23:48 -0700
From: Anton Blanchard <anton@samba.org>
To: tom_gall@vnet.ibm.com
Cc: linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler or kernel source defines
Message-ID: <20010412162348.A17583@va.samba.org>
References: <3AD5F612.E3E282E8@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AD5F612.E3E282E8@vnet.ibm.com>; from tom_gall@vnet.ibm.com on Thu, Apr 12, 2001 at 06:38:10PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

> #ifdef defined(__powerpc__) and !defined(__PPC64__)
>
> 32 bit PPC kernel code
>
> #elif defined(__powerpc__) and defined(__PPC64__)
>
> 64 bit PPC kernel code
>
> #endif
>
>   Seems like the only risk here is that one always assumes to be using gcc and
> that's perfectly valid to me.

Thats what we do in the sparc port. We did have a problem where some
areas used sparc and not __sparc__ and the gcc guys decided to stop
gcc from definining it. But apart from that its been fine.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
