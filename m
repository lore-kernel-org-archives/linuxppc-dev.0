Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8204367DC3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 08:39:25 +1100 (EST)
To: tran vanle <vantranbk@yahoo.com.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: passwd : error 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Nov 2006 00:40:10 +1100."
	<730037.99224.qm@web33015.mail.mud.yahoo.com>
Date: Mon, 20 Nov 2006 22:39:22 +0100
Sender: wd@denx.de
Message-Id: <20061120213922.A4F2B352643@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <730037.99224.qm@web33015.mail.mud.yahoo.com> you wrote:
>
> I use TQM8xxl board with kernel 2.6.11.7 and Ramdisk of ELDK4.0

You are aware that we don't support TQM8xxL systems in the context of
the 2.6 kernel tree yet, aren't you?

> and in /home/ I see 
> drwxr-sr-x    2 -2       -2           1024 Nov 20  2006 van
> in /etc/  i see three file passwd 
> -rwxrwxrwx  1 root       root        291 Nov 20 20:20 passwd
> -rw-------  1 -2         -2          291 Nov 20 20:20 passwd-
> -rwxrwxrwx  1 -2         -2        0 Nov 20 20:20 passwd+
> 
> in nfs dir correlative with /home/ i see
> drwxr-sr-x  2 4294967294 4294967294 1024 Nov 20 20:20 van
> and /etc/
> -rwxrwxrwx  1 root       root        291 Nov 20 20:20 passwd
> -rw-------  1 4294967294 4294967294  291 Nov 20 20:20 passwd-
> -rwxrwxrwx  1 4294967294 4294967294    0 Nov 20 20:20 passwd+

Looks as if you missed to add the no_root_squash option to  your  NFS
server's /etc/exports file...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Knowledge, sir, should be free to all!
	-- Harry Mudd, "I, Mudd", stardate 4513.3
