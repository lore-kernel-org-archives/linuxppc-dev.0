Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s18.bay0.hotmail.com (bay0-omc2-s18.bay0.hotmail.com
	[65.54.246.154]) by ozlabs.org (Postfix) with ESMTP id DDB65DE083
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 May 2007 00:41:59 +1000 (EST)
Message-ID: <BAY115-W173A643AF082D78122CB6DB22F0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Kernel 2.6, ML403, rootfs on nfs, gigabit ethernet link, nfs mount
	problems
Date: Tue, 29 May 2007 14:41:58 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

well I could bring up the grant's kernel on ml403 completely. the root file=
 system was over nfs.=20

when I use a 100mbits link for connection to ml403 , every thing is working=
 suitably.
but when I use a 1000mbits link, I see that ml403 gets ip address from dhcp=
 and mounts the root file system but can not go further , it stops with a m=
essage: "nfs server not responding ...." some thing like this.

when pinging to ml403 with 64 bytes packets, ping works fine for both of 10=
0 and 1000mbits links
but when I try to ping the board with 4000 bytes packets I notice that ml40=
3 on gigabit link can not answer to ping packets, however on 100mbit link e=
very thing works just fine.

any ideas?


_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=
