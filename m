Message-ID: <3AF6F323.7944F695@mvista.com>
Date: Mon, 07 May 2001 15:10:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: machael thailer <dony.he@huawei.com>
Cc: Wolfgang Denk <wd@denx.de>, Cort Dougan <cort@fsmlabs.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Uncompress Ok, but cannot run linux kernel...
References: <001d01c0d5c8$27ae8c60$8021690a@huawei.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


machael thailer wrote:
> ..... But I met
> some urgent problems ...
>     I modified the bootloader codes according to arch/ppc/mbxboot/head.S

For starters, you shouldn't be using this "boot loader" for a 750.....
How did you configure a kernel to get there in the first place?
A 750 should be a CHRP (or PReP, if you have to.....), which will
direct you to a working "chrpboot" boot loader.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
