Message-Id: <20010329233527.Postino-012444@smtp01.highway.ne.jp>
Date: Thu, 29 Mar 2001 23:35:27 +0900
To: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: spin_lock problem in recent kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: tom_gall@vnet.ibm.com
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: spin_lock problem in recent kernel
Date: Thu, 29 Mar 2001 13:46:15 +0000

> > _spin_lock(c02cc470) CPU# 1 NIP c0033404 holder: cpu 1 pc C002B384
> > _spin_lock(c02ce740) CPU# 0 NIP c0015890 holder: cpu 1 pc C0015890
> >
> Hi Kaoru,
>
>   Can you look at your system.map for that kernel and tell me what is at
> addresses:
>
> C0015890
> C002B384
> c02ce740
> c02cc470
>
>   Thanks!
>
>   Tom

HI,Tom
This is getton  data from system.map


<snip>
c00153b0 T schedule_tail
<C001589>
c0015a4c T __wake_up

<snip>
c002b28c T pte_alloc
<C002b384>
c002b3d8 T make_pages_present

<snip>
c02cc42c D init_mm
<c02cc470>
c02cc4d0 D init_task_union

<snip>
c02ce738 d null_pci_ops
<c02ce740>
c02ce750 D kernel_flag

Thanks
Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
