Date: Sun, 22 Aug 2004 11:00:59 +0200
Message-ID: <40F7BFA600107805@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <20040821130102.38184.qmail@web15604.mail.cnb.yahoo.com>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: RE: How to check MTD partition content? 
To: "Song Sam" <samlinuxppc@yahoo.com.cn>,
	"linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>-- Original Message --
>Date: Sat, 21 Aug 2004 21:01:02 +0800 (CST)
>From: Song Sam <samlinuxppc@yahoo.com.cn>
>Subject: How to check MTD partition content?
>To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
>
>
>
>Hi,
>
>I followed the command in DULG to check partition
>content but failed.Target console displayed no such
>command.
>
># xd /dev/mtd3 | head -4
>
>http://www.denx.de/twiki/bin/view/DULG/FlashFilesystemsMTD
>
>Could anyone show me a light?

You can use any program to dump the data on the device, e.g. "od".
Type "man od" for further information.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
