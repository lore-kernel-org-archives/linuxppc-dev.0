Message-ID: <37D9E3CA.C7651EE7@loomer.com>
Date: Fri, 10 Sep 1999 22:08:26 -0700
From: Hugh Caley <hcaley@loomer.com>
MIME-Version: 1.0
To: Paul.Mackerras@cs.anu.edu.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with Samba 2.2 tree
References: <37D8A113.E95181A5@loomer.com> <199909110331.NAA12380@tango.anu.edu.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That fixed it Paul.  Thanks.

Hugh

Paul Mackerras wrote:

> Hugh Caley <hcaley@loomer.com> wrote:
>
> > FYI, Paul, I have been rsyncing the stable tree on my Lombard laptop, and I
> > haven't been able to boot the kernels built with it since sometime after 9/3
> > or so.
>
> Try again now.  In fixing a bug that affected generic configs, I
> inadvertently introduced a bug that stopped pmac-only kernels from
> booting (if booted by BootX).
>
> Paul.

--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
