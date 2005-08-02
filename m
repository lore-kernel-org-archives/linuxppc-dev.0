Return-Path: <ajz@cambridgebroadband.com>
Date: Tue, 2 Aug 2005 09:47:24 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
Message-Id: <20050802094724.342de3bc.ajz@cambridgebroadband.com>
In-Reply-To: <A9DE2BAF233E444FA9C5E77A5825A01E8652FB@ydmail.sbell.com.cn>
References: <A9DE2BAF233E444FA9C5E77A5825A01E8652FB@ydmail.sbell.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: PPC860 board and PPCBoot "verifying Checksum ... Bad Data CRC"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2 Aug 2005 11:26:30 +0800
"FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn> wrote:

> Dear All:
>  I build the ELDK3.1.1  kernel 2.4.25, When bootm or "imi" it shows the  "verifying Checksum ...
>  Bad Data CRC", then stop.
>   But the vmlinux.UBoot is right in Host, How can I do? I use tftpboot to download it. 
>  Thanks!
> 

You may have a RAM error.  Try running mtest in uboot.  (And make sure CFG_MEMTEST_START and
CFG_MEMTEST_END cover the region to which you are downloading uImage.)

Alex
