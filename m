From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3AEA8085.22151@bjapp1>
Date: Sat, 28 Apr 2001 16:34:13 +0800 (CST)
To: Karsten Jeppesen <kj-list@JEPPESENS.COM>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Reply: Re: After mount nfs root filesystem,can't execute /bin/sh.
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Karsten Jeppesen:
	hello,
	I set IMMR address above 8000000 in my boot loader,now kernel work well. I query the miallist in past,same question has been asked before.
Becasue linux use 2G virtual ram address,IMMR valus must be set above 0x8000000.
I think ram address must be share with IMMR address.
	thanks.

Dross Chou


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
