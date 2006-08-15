Return-Path: <david_xtao@yahoo.com>
Received: from web32106.mail.mud.yahoo.com (web32106.mail.mud.yahoo.com
	[68.142.207.120]) by ozlabs.org (Postfix) with SMTP id CBD0867B5F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 05:58:45 +1000 (EST)
Message-ID: <20060815195203.37918.qmail@web32106.mail.mud.yahoo.com>
Date: Tue, 15 Aug 2006 12:52:03 -0700 (PDT)
From: David Tao <david_xtao@yahoo.com>
Subject: CPM2 UARTs: Won't work under low (<= 1200BD) baudrates?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1462451268-1155671523=:35805"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1462451268-1155671523=:35805
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello, guys,


I found that MPC8270 CPM UARTs, both SMCs and SCCs won't work under low baudrate. 

Under 2400 baud or above the UARTs work fine, but once the baudrate set to 1200 or below, there is NO data can be sent out or received even programed to do so.

I am using Linux kernel 2.6.15 (from Denx ELDK4.0). 
 
Can anybody help on this? Thanks in advance.

David


 		
---------------------------------
How low will we go? Check out Yahoo! Messenger’s low  PC-to-Phone call rates.
--0-1462451268-1155671523=:35805
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello, guys,<br><br><br>I found that MPC8270 CPM UARTs, both SMCs and SCCs won't work under low baudrate. <br><br>Under 2400 baud or above the UARTs work fine, but once the baudrate set to 1200 or below, there is NO data can be sent out or received even programed to do so.<br><br>I am using Linux kernel 2.6.15 (from Denx ELDK4.0). <br> <br>Can anybody help on this? Thanks in advance.<br><br>David<br><br><p>&#32;
		<hr size=1>How low will we go? Check out Yahoo! Messenger’s low <a href="http://us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com"> PC-to-Phone call rates.
--0-1462451268-1155671523=:35805--
