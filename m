Message-ID: <001001c0b0e0$3190a5e0$8021690a@huawei.com>
From: "dony" <dony.he@huawei.com.cn>
To: "Amit D Chaudhary" <amitc@brocade.com>
Cc: "Dan Malek" <dan@mvista.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <006401c0af6f$4d1c39e0$8021690a@huawei.com> <3AB6A1C2.60802@brocade.com>
Subject: Re: shell prompt cannot appear after "Freeing unused kernel memory:..."
Date: Tue, 20 Mar 2001 09:50:51 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Is your nfs rootfs correct? Check for /sbin/init, /etc/inittab, etc

Yes, they are OK. I only use sash as my shell .
The same rootfs can work on linux2.2.13+860 .

Any ideas?
machael
>
> michael wrote:
>
> > Hello:
> >     I use ppcboot and can boot kernel with NFS filesystems on my custom
> > board now. But problem occurs ...
> >    When it shows the following:
> > ####################################
> >          ...........................
> >         "VFS:Mounted root(nfs filesystem)".
> >         Freeing unused kernel memory:44k init
> > ####################################
> >
> > At this moment I should have seen "sash#" ,but  nothing happens . I
cannot
> > see anything.
> >
> > I remember that there is a patch for this when I boot kernel on my 860
based
> > custom board last year(linux-2.2.13+860).
> > I don't know if this can work for my 8260 based custom board
> > now(linux-2.4.1+8260).
> > Can you help me?
> >
> > Thank you very much.
> >
> > michael
> >
> >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
