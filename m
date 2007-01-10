Return-Path: <tieuphongit@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by ozlabs.org (Postfix) with ESMTP id 0EDF8DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 02:33:52 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 57so76530wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Jan 2007 07:33:51 -0800 (PST)
Message-ID: <f2042b870701100733v20d7a052kca11f2ef0d108849@mail.gmail.com>
Date: Wed, 10 Jan 2007 22:33:50 +0700
From: "An Le Thien" <tieuphongit@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Can't start snmpd when adding notification handler to the
	configuration file
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8056_9149514.1168443230652"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_8056_9149514.1168443230652
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have a problem when starting snmpd as following:

1. I have just downloaded net-snmp-5.0.6-17_2.src.rpm from
ftp://ftp.sunet.se/pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/sources/target/SRPMS/

2. I used ELDK3.1.1 to build it and install to ramdisk that is used for
TQM8xxL (Using kernel 2.6.11)

3. I used the default configuration (EXAMPLE.conf). When I started snmpd,
the snmpd was started normally.

4. But when I add "trapsink 192.168.1.15 public" to the configuration file.
I can't start snmpd. The following is the configuration file and a log file:

a.  /etc/snmp/snmpd.conf

trapsink 192.168.1.15 public
com2sec local     localhost       public
com2sec mynetwork 192.168.1.0/24      public
......

b. /var/log/snmpd.log

.....
snmp_clean_persistent:  removing old config file: /var/net-snmp/snmpd.0.conf
trace: snmp_call_callbacks(): callback.c, 99
callback: START calling callbacks for maj=1 min=7
trace: snmp_call_callbacks(): callback.c, 107
callback: calling a callback for maj=1 min=7
trace: send_notifications(): notification/snmpNotifyTable.c, 95
send_notifications: starting: pdu=1009abe8, vars=7fffe37c
segmentation faults


Could you give some comments to fix this problem?

Thanks in advance.

An Le.

------=_Part_8056_9149514.1168443230652
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have a problem when starting snmpd as following:<br><br>1. I have just downloaded net-snmp-5.0.6-17_2.src.rpm from <a href="ftp://ftp.sunet.se/pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/sources/target/SRPMS/">
ftp://ftp.sunet.se/pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/sources/target/SRPMS/</a><br><br>2. I used ELDK3.1.1 to build it and install to ramdisk that is used for TQM8xxL (Using kernel 2.6.11)<br><br>3. I used the default configuration (
EXAMPLE.conf). When I started snmpd, the snmpd was started normally.<br><br>4. But when I add &quot;trapsink <a href="http://192.168.1.15">192.168.1.15</a> public&quot; to the configuration file. I can&#39;t start snmpd. The following is the configuration file and a log file:
<br><br>a.&nbsp; /etc/snmp/snmpd.conf<br><br>trapsink <a href="http://192.168.1.15">192.168.1.15</a> public<br>com2sec local&nbsp;&nbsp;&nbsp;&nbsp; localhost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; public<br>com2sec mynetwork <a href="http://192.168.1.0/24">192.168.1.0/24</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; public
<br>......<br><br>b. /var/log/snmpd.log<br><br>.....<br>snmp_clean_persistent:&nbsp; removing old config file: /var/net-snmp/snmpd.0.conf<br>trace: snmp_call_callbacks(): callback.c, 99<br>callback: START calling callbacks for maj=1 min=7
<br>trace: snmp_call_callbacks(): callback.c, 107<br>callback: calling a callback for maj=1 min=7<br>trace: send_notifications(): notification/snmpNotifyTable.c, 95<br>send_notifications: starting: pdu=1009abe8, vars=7fffe37c
<br>segmentation faults<br><br><br>Could you give some comments to fix this problem?<br><br>Thanks in advance.<br><br>An Le.<br>

------=_Part_8056_9149514.1168443230652--
