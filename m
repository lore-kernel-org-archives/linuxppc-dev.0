To: hjzgq@sohu.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Change FEC and SCC1 sequence,But SCC1 not work? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 Jun 2004 17:12:34 +0800."
             <5357004.1086858754080.JavaMail.postfix@mx27.mail.sohu.com>
Date: Thu, 10 Jun 2004 19:17:56 +0200
Message-Id: <20040610171801.09859C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5357004.1086858754080.JavaMail.postfix@mx27.mail.sohu.com> you wrote:
>
> Briefly, my platform is MPC860T from Motorola. I'm using ppcboot 1.1.16
> to tftp the kernel 2.4.4 through FEC and then load NFS/RAMDISK. If I
> configure the kernel with only FEC, then everything works well(NFS
> works and ping through eth0 works). If I configure the kernel with both
> FEC(as eth0) and SCC1(as eth1),it works well too,but when I configure
> ther kernel with both SCC1(eth0) and FEC(as eth1) (net/setup.c)! . I
> try to ping out through FEC(eth1), I get ring buffer dumps and no ping
> response:

Please post the "Kernel command line" as  printed  when  your  kernel
boots.  You  did  include a network device parameter in your ip= boot
argument, didn't you?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
My challenge to the goto-less programmer  is  to  recode  tcp_input()
without any gotos ... without any loss of efficiency (there has to be
a catch).                                             - W. R. Stevens

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
