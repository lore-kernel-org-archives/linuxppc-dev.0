Date: Tue, 23 Jul 2002 10:13:56 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: file->private_data
In-Reply-To: <20020723170424.50300.qmail@web11507.mail.yahoo.com>
Message-ID: <Pine.LNX.4.30.0207231013140.31567-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


That pointer is all yours. Your driver can store data that is specifiec to
each open device using that pointer.

On Tue, 23 Jul 2002, Khai Trinh wrote:

>
> Hi folks,
>
> I am new to linux. So, my question is:
>
> what is file->private_data? Does it set to the device
> structure by the kernel when you register your device
> with devfs_register()?
>
> Thanks,
> --Khai
>
> Yahoo! Health - Feel better, live better
> http://health.yahoo.com
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
