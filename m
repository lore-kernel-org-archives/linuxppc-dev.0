To: =?gb2312?q?song=20sam?= <samsongshzu@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Which kernel tree 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Feb 2004 23:50:27 +0800."
             <20040206155027.83638.qmail@web15211.mail.bjs.yahoo.com>
Date: Fri, 06 Feb 2004 17:00:44 +0100
Message-Id: <20040206160049.EC965C10B2@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Sam,

in message <20040206155027.83638.qmail@web15211.mail.bjs.yahoo.com> you wrote:
>
> > There is also linuxppc_2_4_devel on our CVS server,
> > which is 2.4.24-preX
>
> But how to make it?I used WinCvs in WIN2000 and CVS
> command in REDHAT 7.3 as
> cvs -d :pserver:anonymous@www.denx.de:/cvsroot login
> but couldn't connect.If I use proxty like

I cannot comment on WinCvs (as I've never worked under Windoze),  but
CVS in RH-7.3 will certainly work.

Are you sure that it's not some other configuration on your end which
is preventing CVS from working? Like a firewall blocking the CVS port
(2401) ?

> 172.12.18.1:8080 which I can login your webpage,how
> could I get to linuxppc_2_4_devel?

Use CVS. It works.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Do not follow where the path may lead....go instead where there is no
path and leave a trail.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
