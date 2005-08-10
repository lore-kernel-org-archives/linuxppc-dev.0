Return-Path: <kumar.gala@freescale.com>
Date: Tue, 9 Aug 2005 19:30:41 -0500 (CDT)
From: Kumar Gala <kumar.gala@freescale.com>
To: Prashant Alange <prashant.alange@gmail.com>
In-Reply-To: <6d145b42050809172365209b9e@mail.gmail.com>
Message-ID: <Pine.GSO.4.44.0508091930320.9382-100000@sysperf.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: passing ram= argument to kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I think you want mem=60M

- kumar

On Tue, 9 Aug 2005, Prashant Alange wrote:

> Hi,
> I am trying to pass ram= argument to kernel and my bootcmd is as shown below
>
> tftpboot 03000000 prashant/root.img; tftpboot 00100000 prashant/uImage; setenv b
> ootargs root=/dev/ram ram=60M
> ip=10.67.65.68:10.67.65.39:255.255.255.0:MPC8270:eth1:off; bootm
> 00100000 03000000
>
> I have 64 MB RAM on my system. With above command if I boot the board and see
> cat /proc/meminfo I still see 64MB RAM.
> Can anyone tell me, how to pass ram argument.
>
> Thanks,
> Prashant
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
