Subject: Re: Is there any way for user space program to get IRQ from kernel
	space?
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: =?UTF-8?Q?=EA=B9=80=EC=B9=98?= =?UTF-8?Q?=ED=99=98?= <willy@airpoint.co.kr>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <003501c3e7bd$a84a6970$21589edd@CHKIMVAIO>
References: <003501c3e7bd$a84a6970$21589edd@CHKIMVAIO>
Content-Type: text/plain
Message-Id: <1075730202.16396.108.camel@zambia.cambridgebroadband.com>
Mime-Version: 1.0
Date: 02 Feb 2004 13:56:42 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi,
> I am sure that user space program can't install ISR or get IRQ from
> hardware directly. I'd like to know there is any way a user space
> program to get waked up by a specific hardware IRQ.
>

Create a character device which implements the poll() method,, and use
select() in userspace.

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
