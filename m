Return-Path: <gun_raj@yahoo.com>
Received: from web52405.mail.yahoo.com (web52405.mail.yahoo.com
	[206.190.48.168]) by ozlabs.org (Postfix) with SMTP id 2FCADDDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 17:55:45 +1100 (EST)
Message-ID: <20070308065543.41147.qmail@web52405.mail.yahoo.com>
Date: Wed, 7 Mar 2007 22:55:43 -0800 (PST)
From: ganesh subramonian <gun_raj@yahoo.com>
Subject: /proc/meminfo shows strange values
To: linuxppc-mailing-list <linuxppc-dev@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi=0A=0A=0A=0Awe are using linuxppc-2.4.20 on one of our embedded systems..=
we are monitoring the resource usage in the system with a daemon that reads=
 /proc/meminfo every minute...at some points it shows all the parameters me=
mfree,memcached, buffers all as zero...=0A=0Awe are reading the information=
 from second line of /proc/meminfo...in  another instance it seems that all=
 these parameters are returned in kilobytes rather in bytes..but in fs/proc=
/proc_misc.c all these parameters are left shifted by 12 before printing...=
=0A=0A=0A=0Ais the memory low problem for real?? can some application memor=
y leak lead to this situation??=0A=0Aor is the kernel showing incorrect val=
ues in meminfo??=0A=0A=0A=0A=0A=0Athanks=0A=0Aganesh=0A=0A=0A=0A=0A=0A=0A=
=0A=0A=0A =0A______________________________________________________________=
______________________=0AWe won't tell. Get more on shows you hate to love =
=0A(and love to hate): Yahoo! TV's Guilty Pleasures list.=0Ahttp://tv.yahoo=
.com/collections/265 
