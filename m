Return-Path: <dua.nidhi2007@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186])
	by ozlabs.org (Postfix) with ESMTP id EA9EDDDF13
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jun 2008 00:52:38 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so155410rnf.16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jun 2008 07:52:36 -0700 (PDT)
Message-ID: <d8b992c20806200752k6745b917w5d45efee440778fa@mail.gmail.com>
Date: Fri, 20 Jun 2008 10:52:36 -0400
From: "Nidhi Dua" <dua.nidhi2007@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: u-boot, MPC8313erdb
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8308_5241997.1213973556222"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_8308_5241997.1213973556222
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We are using the board MPC8313ERDB and we are facing problems regarding
u-boot environment variables(the environment variables displayed after
giving 'printenv' command at u-boot prompt).

We are following the steps stated as below:

1. =>printenv

output is:
....
....
bootargs=root=/dev/mtdblock2 rootfstype=jffs2 rw console=ttyS0,115200
bootcmd=bootm fe100000 - fe700000
filesize=1a4a05
fileaddr=200000
ipaddr=192.168.1.101
serverip=192.168.1.57
stdin=serial
stdout=serial
stderr=serial
ethact=TSEC0


Here ethact is TSEC0 by default.

2. =>setenv ethact TSEC1
3. =>saveenv
output:
Saving Environment to Flash...
Un-Protected 1 sectors
Erasing Flash...
. done
Erased 1 sectors
Writing to Flash... done
Protected 1 sectors

Here we have set the ethact variable to TSEC1 and saved it. Now it is
showing that this value of ethact is burnt in flash. But after the board is
reset,

4. =>printenv

ileaddr=200000
ipaddr=192.168.1.101
serverip=192.168.1.57
stdin=serial
stdout=serial
stderr=serial
ethact=TSEC0

Here again the value of ethact is changed to TSEC0.

we have following questions:

question 1: We want to know the reason why it(ethact variable) changes to
TSEC0 everytime with a reset.

question2: After we have set ethact to TSEC1 and saved it(=>saveenv) and
tried to ping the Host from u-boot prompt it is working (displaying: 'host
alive').
But when we are trying to ping Target board from the host it is showing:

PING 192.168.1.101 (192.168.1.101) 56(84) bytes of data.
>From 192.168.1.57 icmp_seq=2 Destination Host Unreachable
>From 192.168.1.57 icmp_seq=3 Destination Host Unreachable
....
....
--- 192.168.1.101 ping statistics ---
12 packets transmitted, 0 received, +9 errors, 100% packet loss, time
11002ms
, pipe 3

Why is it happening so?

question 3: After we have set 'ethact' to TSEC1, the kernel is loaded, and
we have logged -in, when we try to ping the Host from target it says '100%
packet lost'. also we are unable to ping target from the host. Why is it
happening so?

Awaiting a prompt reply
Regards
Nidhi Dua

------=_Part_8308_5241997.1213973556222
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We
are using the board MPC8313ERDB and we are facing problems regarding
u-boot environment variables(the environment variables displayed after
giving &#39;printenv&#39; command at u-boot prompt).<br><br>We are following the steps stated as below:<br><br>1. =&gt;printenv<br><br>output is:<br>....<br>....<br>bootargs=root=/dev/mtdblock2 rootfstype=jffs2 rw console=ttyS0,115200<br>

bootcmd=bootm fe100000 - fe700000<br>filesize=1a4a05<br>fileaddr=200000<br>ipaddr=<a href="http://192.168.1.101/" target="_blank">192.168.1.101</a><br>serverip=<a href="http://192.168.1.57/" target="_blank">192.168.1.57</a><br>
stdin=serial<br>stdout=serial<br>
stderr=serial<br><span style="background-color: rgb(255, 255, 0);">ethact=TSEC0</span><br style="background-color: rgb(255, 255, 0);"><br><br>Here ethact is TSEC0 by default.<br><br>2. =&gt;setenv ethact TSEC1<br>3. =&gt;saveenv<br>

output:<br>Saving Environment to Flash...<br>Un-Protected 1 sectors<br>Erasing
 Flash...<br>. done<br>Erased 1 sectors<br>Writing to Flash... done<br>Protected 1 sectors<br><br>Here
we have set the ethact variable to TSEC1 and saved it. Now it is
showing that this value of ethact is burnt in flash. But after the
board is reset, <br><br>4. =&gt;printenv<br><br>ileaddr=200000<br>
ipaddr=<a href="http://192.168.1.101/" target="_blank">192.168.1.101</a><br>
serverip=<a href="http://192.168.1.57/" target="_blank">192.168.1.57</a><br>
stdin=serial<br>
stdout=serial<br>
stderr=serial<br><span style="background-color: rgb(255, 255, 0);">
ethact=TSEC0</span><br style="background-color: rgb(255, 255, 0);">
<br>Here again the value of ethact is changed to TSEC0.<br><br>we have following questions:<br><br><span style="font-weight: bold; text-decoration: underline; font-style: italic;">question 1</span>: We want to know the reason why it(ethact variable) changes to TSEC0 everytime with a reset.<br>

<br><span style="font-weight: bold; text-decoration: underline; font-style: italic;">question2</span><span style="text-decoration: underline; font-style: italic;">:</span>
After we have set ethact to TSEC1 and saved it(=&gt;saveenv) and tried
to ping the Host from u-boot prompt it is working (displaying: &#39;host
alive&#39;).<br>But when we are trying to ping Target board from the host it is showing:<br><br>PING <a href="http://192.168.1.101/" target="_blank">192.168.1.101</a> (<a href="http://192.168.1.101/" target="_blank">192.168.1.101</a>) 56(84) bytes of data.<br>

>From <a href="http://192.168.1.57/" target="_blank">192.168.1.57</a> icmp_seq=2 Destination Host Unreachable<br>From <a href="http://192.168.1.57/" target="_blank">192.168.1.57</a> icmp_seq=3 Destination Host Unreachable<br>
....<br>....<br>--- <a href="http://192.168.1.101/" target="_blank">192.168.1.101</a> ping statistics ---<br>
12 packets transmitted, 0
 received, +9 errors, 100% packet loss, time 11002ms<br>, pipe 3<br><br>Why is it happening so?<br><br><span style="font-weight: bold; text-decoration: underline; font-style: italic;">question 3</span>:
After we have set &#39;ethact&#39; to TSEC1, the kernel is loaded, and we have
logged -in, when we try to ping the Host from target it says &#39;100%
packet lost&#39;. also we are unable to ping target from the host. Why is
it happening so?<br><br>Awaiting a prompt reply<br>Regards <br><font color="#888888">Nidhi Dua</font>

------=_Part_8308_5241997.1213973556222--
