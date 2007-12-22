Return-Path: <ramkumarj2000@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id CE0BDDDDED
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Dec 2007 19:51:17 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1081318wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Dec 2007 00:51:16 -0800 (PST)
Message-ID: <4f8c3030712220051if731af9g350af9d45a75c244@mail.gmail.com>
Date: Sat, 22 Dec 2007 16:51:16 +0800
From: "ramkumarj Ramkumar" <ramkumarj2000@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Loop at starting pid 164, tty '': '/sbin/getty'
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3671_18987761.1198313476407"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_3671_18987761.1198313476407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I m trying to run Linux 2.6 ( From Grant) on ML-403. I used the
busybox-1.7.2. During booting, I found the following logs and it keeps
trying to respawn the getty.It keeps looping and I never see the login
prompt.  Am I missing something.

<snip>
Starting system...
mounting /proc: done.
Mounting '/' read-write: done.
brining up loopback interface: done.
Mounting /tmp: done.
Starting syslogd: done.
Starting klogd: done.
Starting inetd: done.
System started.
starting pid 163, tty '': '/sbin/getty'
[    7.218444] XSysAce: Queue is plugged
process '/sbin/getty 38400 tts/0' (pid 163) exited. Scheduling it for
restart.
starting pid 164, tty '': '/sbin/getty'
process '/sbin/getty 38400 tts/0' (pid 164) exited. Scheduling it for
restart.
starting pid 165, tty '': '/sbin/getty'

Any suggestion or pointers would be very helpful.

Best Regards,
Ramkumar

------=_Part_3671_18987761.1198313476407
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>I m trying to run Linux 2.6 ( From Grant) on ML-403. I used the busybox-1.7.2. During booting, I found the following logs and it keeps trying to respawn the getty.It keeps looping and I never see the login prompt. &nbsp;Am I missing something.
</div>
<div>&nbsp;</div>
<div>&lt;snip&gt;</div>
<div>Starting system...<br>mounting /proc: done.<br>Mounting &#39;/&#39; read-write: done.<br>brining up loopback interface: done.<br>Mounting /tmp: done.<br>Starting syslogd: done.<br>Starting klogd: done.<br>Starting inetd: done. 
<br>System started.<br>starting pid 163, tty &#39;&#39;: &#39;/sbin/getty&#39;<br>[&nbsp;&nbsp;&nbsp; 7.218444] XSysAce: Queue is plugged<br>process &#39;/sbin/getty 38400 tts/0&#39; (pid 163) exited. Scheduling it for restart.<br>starting pid 164, tty &#39;&#39;: &#39;/sbin/getty&#39; 
<br>process &#39;/sbin/getty 38400 tts/0&#39; (pid 164) exited. Scheduling it for restart.<br>starting pid 165, tty &#39;&#39;: &#39;/sbin/getty&#39;</div>
<div>&nbsp;</div>
<div>Any suggestion or pointers would be very helpful.</div>
<div>&nbsp;</div>
<div>Best Regards,</div>
<div>Ramkumar</div>

------=_Part_3671_18987761.1198313476407--
