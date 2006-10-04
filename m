Return-Path: <vancasperz@yahoo.com.cn>
Received: from web15612.mail.cnb.yahoo.com (web15612.mail.cnb.yahoo.com
	[202.165.102.208]) by ozlabs.org (Postfix) with SMTP id 76CE967CC7
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 23:33:19 +1000 (EST)
Message-ID: <20061004133317.19319.qmail@web15612.mail.cnb.yahoo.com>
Date: Wed, 4 Oct 2006 21:33:17 +0800 (CST)
From: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: Problem of "Connecting to BDI loader failed (-1201)"
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-30400692-1159968797=:19175"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-30400692-1159968797=:19175
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello,
I am a newbie for BDI2000. Today I tried to setup BDI2000 for PPC405EP PPChameleonEVB board. I did the initial setup based on the manual:
1. make (to compile the executable "bdisetup")
2. ./bdisetup -u -p/dev/ttyS0 -b57 -aGDB -tPPC400
3. ./bdisetup -c -p/dev/ttyS0 -b57 -i192.168.1.123 -h192.168.1.104 -m255.255.255.0 -g192.168.1.239 -foctobus.cfg
4. ./bdisetup -v -p/dev/ttyS0 -b57 -s
5. telnet 192.168.1.123
Then the telnet ran well. But after I quitted from telnet and tried to run "./bdisetup -v -p/dev/ttyS0 -b57", I got "Connecting to BDI loader failed (-1201)Connecting to BDI loader failed (-1201)". And I got the same results when I tried others parameters such as -u, -c, -e. So would anyone give me some advice about this? Thanks a lot.

Best wishes


Zhou Rui
Distributed & Embedded System Lab
School of Information Science & Engineering
Lanzhou University, P. R. China
http://dslab.lzu.edu.cn/~zr/
 		
---------------------------------
 Mp3疯狂搜-新歌热歌高速下   
--0-30400692-1159968797=:19175
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello,<br>I am a newbie for BDI2000. Today I tried to setup BDI2000 for PPC405EP PPChameleonEVB board. I did the initial setup based on the manual:<br>1. make (to compile the executable "bdisetup")<br>2. ./bdisetup -u -p/dev/ttyS0 -b57 -aGDB -tPPC400<br>3. ./bdisetup -c -p/dev/ttyS0 -b57 -i192.168.1.123 -h192.168.1.104 -m255.255.255.0 -g192.168.1.239 -foctobus.cfg<br>4. ./bdisetup -v -p/dev/ttyS0 -b57 -s<br>5. telnet 192.168.1.123<br>Then the telnet ran well. But after I quitted from telnet and tried to run "./bdisetup -v -p/dev/ttyS0 -b57", I got "Connecting to BDI loader failed (-1201)Connecting to BDI loader failed (-1201)". And I got the same results when I tried others parameters such as -u, -c, -e. So would anyone give me some advice about this? Thanks a lot.<br><br>Best wishes<br><BR><BR>Zhou Rui<br>Distributed &amp; Embedded System Lab<br>School of Information Science &amp; Engineering<br>Lanzhou University, P. R. China<br>http://dslab.lzu.edu.cn/~zr/<p>&#32;
		<hr size=1><a href="http://music.yahoo.com.cn/?source=mail_mailbox_footer" target=blank> 
Mp3疯狂搜-新歌热歌高速下 
</a>
 
 

--0-30400692-1159968797=:19175--
