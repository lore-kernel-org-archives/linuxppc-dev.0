Message-ID: <3E2853C9.3090607@occamnetworks.com>
Date: Fri, 17 Jan 2003 11:04:41 -0800
From: Kedar Madineni <kedar@occamnetworks.com>
MIME-Version: 1.0
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: A few questions in embedded linux
References: <20030117181544.14483.qmail@web11505.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Khai Trinh wrote:
> Hi folks,
>
> We are developing a PCI adapter card based out of the
> PPC440GP using MVL version 2.1 (kernel 2.4.17).
>
> I have several issues as listed below:
>
> 1. I'd like to reserve a 4M RAM space for DMA
> purposes. What I did was adding
> CONFIG_CMD_LINE="root=60M" since our board has 64MB of

mem=60M should be the option. Read the help.

> RAM. How do I know the system really now configure to
> be only 60MB? How then can I get a virtual addr to the
> 4MB DMA buffer? I did ioremap() given it the start of
> the 60MB RAM physical addr, but I get a bus error with
> the following message:

check and use high_memory ........



>
> Jan 1 00:01:42 199 kernel: __ioremap(): phys addr
> 3c00000 is RAM lr c000a57c
>
> 2. We have a list of files (ie: hhlfiles) required to
> build a RAM DISK that is non networked. What other
> files involved that we need to build a RAM DISK that
> has full network capability( ie: telnet, ftp, ping,
> rlogin, mount, etc...)?
>
> 3. When the ethernet driver comes up it does a bootp
> request to find its IP address.... How do we configure
> it such that it picks it up from a file or flash?
>
> Thanks,
>
> --Khai
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
