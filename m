Return-Path: <vantranbk@yahoo.com.au>
Received: from web33011.mail.mud.yahoo.com (web33011.mail.mud.yahoo.com
	[209.191.69.126]) by ozlabs.org (Postfix) with SMTP id 507B5DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Dec 2006 01:04:46 +1100 (EST)
Date: Wed, 27 Dec 2006 00:58:05 +1100 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: net-snmp : can not start with trapsink
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1996516316-1167141485=:48372"
Message-ID: <550902.48372.qm@web33011.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1996516316-1167141485=:48372
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all
I have just rebuild net-snmp in ELDK 4.0 . 
when I start with config file 
#snmpd.conf
rwuser root

It run ok
But when I add these line
#snmpd.conf
rwuser root
authtrapenable 1
trapcommunity  public
trapsink      localhost public 5060
informsink      localhost public 5060
trap2sink      localhost public 5060

I can not start snmpd (I run snmpd -D).

Which option when configure may I miss? If not how can I fix it


Thanks all




Happy new year

 Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-1996516316-1167141485=:48372
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all<br>I have just rebuild net-snmp in ELDK 4.0 . <br>when I start with config file <br>#snmpd.conf<br>rwuser root<br><br>It run ok<br>But when I add these line<br>#snmpd.conf<br>rwuser root<br>authtrapenable 1<br>trapcommunity&nbsp; public<br>trapsink&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localhost public 5060<br>informsink&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localhost public 5060<br>trap2sink&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localhost public 5060<br><br>I can not start snmpd (I run snmpd -D).<br><br>Which option when configure may I miss? If not how can I fix it<br><br><br>Thanks all<br><br><br><br><br>Happy new year<br><p>&#32;Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-1996516316-1167141485=:48372--
