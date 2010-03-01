Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83507.mail.sp1.yahoo.com (web83507.mail.sp1.yahoo.com
	[216.252.120.163]) by ozlabs.org (Postfix) with SMTP id 60F0FB7D9E
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Mar 2010 05:43:58 +1100 (EST)
Message-ID: <248783.45498.qm@web83507.mail.sp1.yahoo.com>
Date: Mon, 1 Mar 2010 10:43:57 -0800 (PST)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: JFFS2 warnings
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm getting a bunch of these after I 'reboot' or 'poweroff'
several times.

Empty flash at 0x0056205c ends at 0x00562800
Empty flash at 0x00565334 ends at 0x00565800
Empty flash at 0x00576104 ends at 0x00576800

JFFS2 notice: (848) check_node_data: wrong data CRC
in data node at 0x00577034: read 0xe6adad18, calculated
0x202a305c.
JFFS2 notice: (848) check_node_data: wrong data CRC
in data node at 0x00575768: read 0xe6adad18, calculated
0xfc64f8a3.

I'm not too sure why I'm getting these, but recently
they seem to have caused a few problems with parts of
my filesystem (i.e. programs not running correctly).

Can someone tell me what these are or what could be
causing them?

I'm using 2.6.33rc1 and this is on an mpc8313 based board.
Not sure what other info would be useful.

Thanks,

Ron
