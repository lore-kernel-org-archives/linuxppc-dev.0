Return-Path: <bharthik2004@yahoo.com>
Received: from web50008.mail.yahoo.com (web50008.mail.yahoo.com
	[206.190.38.23]) by ozlabs.org (Postfix) with SMTP id AB33768917
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 18:19:13 +1100 (EST)
Message-ID: <20051231071231.54555.qmail@web50008.mail.yahoo.com>
Date: Fri, 30 Dec 2005 23:12:31 -0800 (PST)
From: bharathi kandimalla <bharthik2004@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-304368131-1136013151=:53112"
Subject: tftp
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-304368131-1136013151=:53112
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi
     I am working on the MPC860T .I am able to port the linux2.6  on to the board.I got prompt. eventhough I have enabled the tftp   I am not able to get the files  using tftp
  from the host machine
  fconfig
eth0      Link encap:Ethernet  HWaddr 9A:52:63:15:85:25
          inet addr:192.168.3.2  Bcast:192.168.3.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:512 (512.0 B)  TX bytes:0 (0.0 B)
          Base address:0xe00
  lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
   
  [root@(none) ~]# tftp
-sh: tftp: command not found
   
  please help me out
  regards
  bharathi  
   
   

		
---------------------------------
 Yahoo! DSL Something to write home about. Just $16.99/mo. or less
--0-304368131-1136013151=:53112
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>Hi</DIV>  <DIV id=RTEContent>&nbsp;&nbsp; I am working on the MPC860T .I am able to port the linux2.6&nbsp; on to the board.I got prompt. eventhough I have enabled the tftp&nbsp;&nbsp; I am not able to get the files&nbsp; using tftp</DIV>  <DIV id=RTEContent>from the host machine</DIV>  <DIV id=RTEContent>fconfig<BR>eth0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 9A:52:63:15:85:25<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet addr:192.168.3.2&nbsp; Bcast:192.168.3.255&nbsp; Mask:255.255.255.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:8 errors:0 dropped:0 overruns:0 frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:0 errors:0 dropped:0 overruns:0 carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0
 txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:512 (512.0 B)&nbsp; TX bytes:0 (0.0 B)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0xe00</DIV>  <DIV id=RTEContent>lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Local Loopback<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet addr:127.0.0.1&nbsp; Mask:255.0.0.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP LOOPBACK RUNNING&nbsp; MTU:16436&nbsp; Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:0 errors:0 dropped:0 overruns:0 frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:0 errors:0 dropped:0 overruns:0 carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 (0.0 B)&nbsp; TX bytes:0 (0.0 B)</DIV>  <DIV id=RTEContent>&nbsp;</DIV>  <DIV id=RTEContent>[root@(none) ~]#
 tftp<BR>-sh: tftp: command not found</DIV>  <DIV id=RTEContent>&nbsp;</DIV>  <DIV id=RTEContent>please help me out</DIV>  <DIV id=RTEContent>regards</DIV>  <DIV id=RTEContent>bharathi&nbsp; </DIV>  <DIV id=RTEContent>&nbsp;</DIV>  <DIV id=RTEContent>&nbsp;</DIV><p>
		<hr size=1> <a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=37474/*http://promo.yahoo.com/broadband/ 
">Yahoo! DSL</a> Something to write home about. Just $16.99/mo. or less
--0-304368131-1136013151=:53112--
