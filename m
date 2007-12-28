Return-Path: <cecolong@yahoo.com>
Received: from web34413.mail.mud.yahoo.com (web34413.mail.mud.yahoo.com
	[66.163.178.162]) by ozlabs.org (Postfix) with SMTP id 7D23EDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 14:55:52 +1100 (EST)
Date: Thu, 27 Dec 2007 19:49:09 -0800 (PST)
From: goog long <cecolong@yahoo.com>
Subject: 2.6.10 kernel hangs after timer_init
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1703318137-1198813749=:17819"
Message-ID: <912804.17819.qm@web34413.mail.mud.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1703318137-1198813749=:17819
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

2.6.10 kernel hangs on my board with PPC64 processors. The log is below. There must be a fix for this somewhere because it boots just fine on 2.6.14 kernel. Could someone please point me to the fix for this?

time_init: decrementer frequency = 112.500000 MHz
time_init: processor frequency   = 1800.000000 MHz
 -> set_preferred_console()
stdout is /ht@0/isa@8,2/serial@a0
Found serial console at ttyS0
smp_prepare_cpus
smp_mpic_probe()...
nr_cpus: 2
smp: kicking cpu 1
       
---------------------------------
Never miss a thing.   Make Yahoo your homepage.
--0-1703318137-1198813749=:17819
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

2.6.10 kernel hangs on my board with PPC64 processors. The log is below. There must be a fix for this somewhere because it boots just fine on 2.6.14 kernel. Could someone please point me to the fix for this?<br><br>time_init: decrementer frequency = 112.500000 MHz<br>time_init: processor frequency&nbsp;&nbsp; = 1800.000000 MHz<br>&nbsp;-&gt; set_preferred_console()<br>stdout is /ht@0/isa@8,2/serial@a0<br>Found serial console at ttyS0<br>smp_prepare_cpus<br>smp_mpic_probe()...<br>nr_cpus: 2<br>smp: kicking <span style="border-bottom: 1px dashed rgb(0, 102, 204); cursor: pointer;" class="yshortcuts" id="lw_1198813711_0">cpu</span> 1<p>&#32;



      <hr size=1>Never miss a thing.  <a href="http://us.rd.yahoo.com/evt=51438/*http://www.yahoo.com/r/hs"> Make Yahoo your homepage.</a>


--0-1703318137-1198813749=:17819--
