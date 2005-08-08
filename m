Return-Path: <mjoshi_blr@yahoo.com>
Received: from web40724.mail.yahoo.com (web40724.mail.yahoo.com [66.218.92.62])
	by ozlabs.org (Postfix) with SMTP id 0684F67E6B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2005 06:33:50 +1000 (EST)
Message-ID: <20050808202710.77644.qmail@web40724.mail.yahoo.com>
Date: Mon, 8 Aug 2005 13:27:10 -0700 (PDT)
From: Manish Joshi <mjoshi_blr@yahoo.com>
To: Wolfgang Denk <wd@denx.de>,
	FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn>
In-Reply-To: <20050805091633.8EF0E352633@atlas.denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2073826838-1123532830=:76514"
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

--0-2073826838-1123532830=:76514
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hope you are connecting with right port speed. 

Wolfgang Denk <wd@denx.de> wrote:In message you wrote:
> 
> I meet a problem when porting kernel 2.4.25,and 2.6.12 to a HD860
> board: Whatever your config, or whatever you patch, set ppcboot
> enviroment, 
> whether use ramdisk or nfs, the kernel all display a message then
> halt.

How do you define "halt"? There is no "halt" instruction in the CPU,
so it must be doing "something".

> The log_buf in Memory display that the kernel has problem at : 
> 
> 1. /init/main.c calibrate_delay() ;
> 2. /init/main.c do_initcalls() do while dead loop!! 
> 3. /init/do_mounts.c mount_root() 

Locate the problems and fix them.

> Does it need any patches? thanks!
> The kernel 2.4.25 is from ELDK 3.1.1, 2.6.12.3 is from kernel.org

this kernel works fine on many, many other boards. It's extremely
likely that the problems are caused by your port only.

Best regards,

Wolfgang Denk

-- 
Software Engineering: Embedded and Realtime Systems, Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A person who is more than casually interested in computers should be
well schooled in machine language, since it is a fundamental part of
a computer. -- Donald Knuth
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


		
---------------------------------
 Start your day with Yahoo! - make it your home page 
--0-2073826838-1123532830=:76514
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hope you are connecting with right port speed. <BR><BR><B><I>Wolfgang Denk &lt;wd@denx.de&gt;</I></B> wrote:
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">In message <A9DE2BAF233E444FA9C5E77A5825A01E865055@YDMAIL.SBELL.COM.CN>you wrote:<BR>&gt; <BR>&gt; I meet a problem when porting kernel 2.4.25,and 2.6.12 to a HD860<BR>&gt; board: Whatever your config, or whatever you patch, set ppcboot<BR>&gt; enviroment, <BR>&gt; whether use ramdisk or nfs, the kernel all display a message then<BR>&gt; halt.<BR><BR>How do you define "halt"? There is no "halt" instruction in the CPU,<BR>so it must be doing "something".<BR><BR>&gt; The log_buf in Memory display that the kernel has problem at : <BR>&gt; <BR>&gt; 1. /init/main.c calibrate_delay() ;<BR>&gt; 2. /init/main.c do_initcalls() do while dead loop!! <BR>&gt; 3. /init/do_mounts.c mount_root() <BR><BR>Locate the problems and fix them.<BR><BR>&gt; Does it need any patches? thanks!<BR>&gt; The kernel 2.4.25 is from ELDK 3.1.1, 2.6.12.3 is from kernel.org<BR><BR>this kernel works fine on many, many
 other boards. It's extremely<BR>likely that the problems are caused by your port only.<BR><BR>Best regards,<BR><BR>Wolfgang Denk<BR><BR>-- <BR>Software Engineering: Embedded and Realtime Systems, Embedded Linux<BR>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de<BR>A person who is more than casually interested in computers should be<BR>well schooled in machine language, since it is a fundamental part of<BR>a computer. -- Donald Knuth<BR>_______________________________________________<BR>Linuxppc-embedded mailing list<BR>Linuxppc-embedded@ozlabs.org<BR>https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR></BLOCKQUOTE></DIV><p>
		<hr size=1> <a href="http://us.rd.yahoo.com/evt=34442/*http://www.yahoo.com/r/hs">Start your day with Yahoo! - make it your home page </a>
--0-2073826838-1123532830=:76514--
