From: bharat <bharat@coraltele.com>
To: Mark Hatle <mhatle@mvista.com>
Subject: Re: regarding ld.so.preloads,ld.so.cache
Date: Wed, 9 Jun 2004 10:35:21 +0530
References: <28007367.1086432866812.JavaMail.administrator@RnDserver> <2755028.1086671873328.JavaMail.administrator@RnDserver> <5202403.1086706828281.JavaMail.administrator@RnDserver>
In-Reply-To: <5202403.1086706828281.JavaMail.administrator@RnDserver>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <8768038.1086757492296.JavaMail.administrator@RnDserver>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi Mark
            there is not effect of rebooting  my NFS server  it keeps on
allowing the mounting of filesystem to my client.
the NFS mounted client starts looking for sbin/init it founds then it starts
executing some scripts and then hangs after executing  some of them moreover
it donot hangs at a particular file .
                              i am mounting /opt/hardhat/devkit/ppc/8xx/target
directory to the client is this correct? or i should also make some changes
in some files to allow as i read in Karim yaghmour book  to make changes in
libc.so file
 to change every appearance of /lib/libc.so.6 to libc.so.6 should i make the
same changes
please guide me as i have just started working in embedded field and a novice
waiting for your response
bharat


On Tuesday 08 June 2004 08:24 pm, you wrote:

> I don't completely understand your response.  Specific did rebooting
> your NFS server allow for you to boot once without a problem?
>
> If so then this is definatly an RTC related problem.  You will need to
> implement a proper real-time clock in the kernel before it starts using
> the NFS root filesystem.
>
> --Mark
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
