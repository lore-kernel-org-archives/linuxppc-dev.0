Return-Path: <pradeepsampath@yahoo.com>
Received: from web83210.mail.mud.yahoo.com (web83210.mail.mud.yahoo.com
	[216.252.101.66]) by ozlabs.org (Postfix) with SMTP id 0A7E767CB8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 07:46:42 +1000 (EST)
Message-ID: <20061003214641.48214.qmail@web83210.mail.mud.yahoo.com>
Date: Tue, 3 Oct 2006 14:46:41 -0700 (PDT)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: booting 2.6 kernel on ML403
To: Ameet Patil <ammubhai@gmail.com>
In-Reply-To: <45221E5A.6040800@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1337209284-1159912001=:47295"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1337209284-1159912001=:47295
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Ameet,
  Thanks for the instant reply. I changed root parameter to xsa as you suggested root=/dev/xsa2. But i still get the same failure.
   
  [    3.093694] TCP bic registered
[    3.129458] NET: Registered protocol family 8
[    3.181412] NET: Registered protocol family 20
[    3.236744] VFS: Cannot open root device "xsa2" or unknown-block(0,0)
[    3.313092] Please append a correct "root=" boot option
[    3.375552] Kernel panic - not syncing: VFS: Unable to mount root fs on unkno
wn-block(0,0)
[    3.474504]  <0>Rebooting in 180 seconds..
  
 
  On the CF i created the following block and character device files
  # mknod -m 660 console c 5 1
# mknod -m 660 xsa b 254 0
# mknod -m 660 xsa1 b 254 1
# mknod -m 660 xsa2 b 254 2
# mknod -m 660 xsa3 b 254 3
mkdir tts
# mknod -m 660 0 c 4 64

> Problem 2:
> - Untar the kernel 2.6.17.1
> - Applied the 5 TEMAC patches
> - Applied Ameet's Sysace patch
which patch did you apply? For TEMAC... apply the following patch: 
http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2-after-TEMAC.patch

  Yes, i have applied *only* after-TEMAC.patch. But looks like it blows away the configuration and results in kernel hang.
   
  Any further suggestions on where i should look at.
   
  regards.
  Pradeep

--0-1337209284-1159912001=:47295
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi Ameet,</DIV>  <DIV>Thanks for the instant reply. I changed root parameter to xsa as you suggested root=/dev/xsa2. But i still get the same failure.</DIV>  <DIV>&nbsp;</DIV>  <DIV>[&nbsp;&nbsp;&nbsp; 3.093694] TCP bic registered<BR>[&nbsp;&nbsp;&nbsp; 3.129458] NET: Registered protocol family 8<BR>[&nbsp;&nbsp;&nbsp; 3.181412] NET: Registered protocol family 20<BR>[&nbsp;&nbsp;&nbsp; 3.236744] VFS: Cannot open root device "xsa2" or unknown-block(0,0)<BR>[&nbsp;&nbsp;&nbsp; 3.313092] Please append a correct "root=" boot option<BR>[&nbsp;&nbsp;&nbsp; 3.375552] Kernel panic - not syncing: VFS: Unable to mount root fs on unkno<BR>wn-block(0,0)<BR>[&nbsp;&nbsp;&nbsp; 3.474504]&nbsp; &lt;0&gt;Rebooting in 180 seconds..</DIV>  <DIV><BR>&nbsp;</DIV>  <DIV>On the CF i created the following block and character device files</DIV>  <DIV># mknod -m 660 console c 5 1<BR># mknod -m 660&nbsp;xsa b 254 0<BR># mknod -m 660 xsa1 b 254 1<BR># mknod -m 660 xsa2 b 254 2<BR># mknod -m 660
 xsa3 b 254 3<BR>mkdir tts<BR># mknod -m 660 0&nbsp;c 4 64<BR><BR><?xml:namespace prefix = mailto /><mailto:psampath@psampath-test>&gt; Problem 2:<BR>&gt; - Untar the kernel 2.6.17.1<BR>&gt; - Applied the 5 TEMAC patches<BR>&gt; - Applied Ameet's Sysace patch<BR>which patch did you apply? For TEMAC... apply the following patch: <BR><A href="http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2-after-TEMAC.patch">http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2-after-TEMAC.patch</A><BR></mailto:psampath@psampath-test></DIV>  <DIV><mailto:psampath@psampath-test>Yes, i have applied *only* after-TEMAC.patch. But looks like it blows away the configuration and results in kernel hang.</mailto:psampath@psampath-test></DIV>  <DIV><mailto:psampath@psampath-test></mailto:psampath@psampath-test>&nbsp;</DIV>  <DIV><mailto:psampath@psampath-test>Any further suggestions on where i should look
 at.</mailto:psampath@psampath-test></DIV>  <DIV><mailto:psampath@psampath-test></mailto:psampath@psampath-test>&nbsp;</DIV>  <DIV><mailto:psampath@psampath-test>regards.</mailto:psampath@psampath-test></DIV>  <DIV><mailto:psampath@psampath-test>Pradeep</mailto:psampath@psampath-test></DIV><mailto:psampath@psampath-test></mailto:psampath@psampath-test>
--0-1337209284-1159912001=:47295--
