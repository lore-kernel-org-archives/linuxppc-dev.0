Return-Path: <wd@denx.de>
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 Aug 2005 09:11:25 +0800."
	<A9DE2BAF233E444FA9C5E77A5825A01E865055@ydmail.sbell.com.cn>
Date: Fri, 05 Aug 2005 11:16:33 +0200
Sender: wd@denx.de
Message-Id: <20050805091633.8EF0E352633@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: The kernel halt after "transferring control to
	linux(0x000000)..." on HD860(MPC860SR) board kernel 2.4.25,
	and 2.6.12
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <A9DE2BAF233E444FA9C5E77A5825A01E865055@ydmail.sbell.com.cn> you wrote:
> 
>   I meet a problem when porting kernel  2.4.25,and 2.6.12 to a HD860
> board: Whatever your config, or whatever you patch, set ppcboot
> enviroment, 
>   whether use ramdisk or nfs, the kernel  all display a message then
> halt.

How do you define "halt"? There is no "halt" instruction in the  CPU,
so it must be doing "something".

>   The log_buf in Memory display that the kernel has problem at : 
> 
>   1. /init/main.c  calibrate_delay() ;
>   2. /init/main.c  do_initcalls() do while dead loop!! 
>   3. /init/do_mounts.c mount_root() 

Locate the problems and fix them.

>  Does it need any patches? thanks!
>  The kernel 2.4.25 is from ELDK 3.1.1, 2.6.12.3 is from kernel.org

this kernel works fine on many, many  other  boards.  It's  extremely
likely that the problems are caused by your port only.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A person who is more than casually interested in computers should  be
well  schooled in machine language, since it is a fundamental part of
a computer.                                           -- Donald Knuth
