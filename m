Date: Sat, 11 Sep 1999 13:31:08 +1000
Message-Id: <199909110331.NAA12380@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: hcaley@loomer.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <37D8A113.E95181A5@loomer.com> (message from Hugh Caley on Thu,
	09 Sep 1999 23:11:32 -0700)
Subject: Re: Problems with Samba 2.2 tree
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <37D8A113.E95181A5@loomer.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hugh Caley <hcaley@loomer.com> wrote:

> FYI, Paul, I have been rsyncing the stable tree on my Lombard laptop, and I
> haven't been able to boot the kernels built with it since sometime after 9/3
> or so.

Try again now.  In fixing a bug that affected generic configs, I
inadvertently introduced a bug that stopped pmac-only kernels from
booting (if booted by BootX).

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
