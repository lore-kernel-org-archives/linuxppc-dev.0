Message-ID: <3AB6A1C2.60802@brocade.com>
Date: Mon, 19 Mar 2001 16:18:10 -0800
From: Amit D Chaudhary <amitc@brocade.com>
MIME-Version: 1.0
To: michael <dony.he@huawei.com.cn>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: shell prompt cannot appear after "Freeing unused kernel memory:..."
References: <006401c0af6f$4d1c39e0$8021690a@huawei.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Is your nfs rootfs correct? Check for /sbin/init, /etc/inittab, etc

Amit

michael wrote:

> Hello:
>     I use ppcboot and can boot kernel with NFS filesystems on my custom
> board now. But problem occurs ...
>    When it shows the following:
> ####################################
>          ...........................
>         "VFS:Mounted root(nfs filesystem)".
>         Freeing unused kernel memory:44k init
> ####################################
>
> At this moment I should have seen "sash#" ,but  nothing happens . I cannot
> see anything.
>
> I remember that there is a patch for this when I boot kernel on my 860 based
> custom board last year(linux-2.2.13+860).
> I don't know if this can work for my 8260 based custom board
> now(linux-2.4.1+8260).
> Can you help me?
>
> Thank you very much.
>
> michael
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
