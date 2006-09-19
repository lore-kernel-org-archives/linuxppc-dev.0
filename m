Return-Path: <junijoseph@yahoo.co.in>
Received: from web8408.mail.in.yahoo.com (web8408.mail.in.yahoo.com
	[202.43.219.156]) by ozlabs.org (Postfix) with SMTP id A862267B62
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 08:43:51 +1000 (EST)
Message-ID: <20060919224349.25812.qmail@web8408.mail.in.yahoo.com>
Date: Tue, 19 Sep 2006 23:43:49 +0100 (BST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: linux-2.6 system ACE driver - need help
To: linuxppc-embedded@ozlabs.org, ammubhai@gmail.com
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1757925272-1158705829=:24624"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1757925272-1158705829=:24624
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Ameet

I have posted a few messages regarding Ssytem ACE driver for Linux-2.6.

We are working on a AMCC 440SPe based custom board.

We applied the patch from

http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch
 and applied against 2.6.16-2 kernel.

We are trying to make the driver work in interrupt mode.

First, I would like to know if the driver tested in interrupt mode.

We are able to mount the CF, but it is very inconsistent.

Same is the case with fdisk command. When it fails,we get errors which you could see in the screen-dump below.

Are we missing to apply the right patch? Please let us know your inputs to go forward.
Looking forwards for your reply.

Thanks
Junita

/*************** Screen dump ********************/
# fdisk /dev/xsysace
  1. sector = 0 xsa_cur_req->sector=0
  System ACE: Error 0 when reading sector 2.
  2. sector = 2 xsa_cur_req->sector=16
  end_request: I/O error, System ACE: Error 0 when reading sectoru dev xsa, sector 16
  Buffer I/O error on device xsa, logical block 2
  1. sector = 184 xsa_cur_req->sector=184
   
  Command (m for help): p
   
  Disk /dev/xsysace: 524 MB, 524869632 bytes
  17 heads, 59 sectors/track, 1022 cylinders
  Units = cylinders of 1003 * 512 = 513536 bytes
   
         Device Boot      Start         End      Blocks   Id  System
  /dev/xsysace1               1        1022      512503+   6  FAT16
   
  Command (m for help): q
    And for 'mount'  #
  #
  # mount -t msdos /dev/xsysace /root/cf
  1. sector = 0 xsa_cur_req->sector=0
  1. sector = 503 xsa_cur_req->sector=503
  1. sector = 504 xsa_cur_req->sector=504
  1. sector = 506 xsa_cur_req->sector=506
  1. sector = 508 xsa_cur_req->sector=508
  1. sector = 510 xsa_cur_req->sector=510
  # cd /root/cf
  < Here Prints Some Symbols like + - etc, which i am
    not able to capture/copy -------------ERROR
  b: No such file or directory--------------------------------ERROR
  pci.h
  #
  Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.n0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.d#
  # cp pci.h /root/
  # cd ../
  # ls
  app     cf      hello1  pci.h
    #
  #/root
   /dev/xsysace /root/cf
  FAT: bogus number of reserved sectors
  VFS: Can't find a valid FAT filesystem on dev xsa.
  mount: Mounting /dev/xsysace on /root/cf failed: Invalid argument
  #
   
  










 				
---------------------------------
 Find out what India is talking about on  - Yahoo! Answers India 
 Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. Get it NOW
--0-1757925272-1158705829=:24624
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Ameet<br><br>I have posted a few messages regarding Ssytem ACE driver for Linux-2.6.<br><br>We are working on a AMCC 440SPe based custom board.<br><br>We applied the patch from<br><pre><i><i><a href="http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch">http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch</a><br> </i></i><span style="font-family: arial;">and applied against 2.6.16-2 kernel.</span><br style="font-family: arial;"><br style="font-family: arial;"><span style="font-family: arial;">We are trying to make the driver work in interrupt mode.<br><br style="font-family: arial;"></span><span style="font-family: arial;">First, I would like to know if the driver tested in interrupt mode.<br><br style="font-family: arial;"></span><span style="font-family: arial;">We are able to mount the CF, but it is very inconsistent.</span><br style="font-family: arial;"><br style="font-family:
 arial;"><span style="font-family: arial;">Same is the case with fdisk command. </span><span style="font-family: arial;">When it fails,we get errors which</span><span style="font-family: arial;"> you could see in the screen-dump below.</span><i><i><br></i></i></pre><div class="MsoPlainText">Are we missing to apply the right patch? Please let us know your inputs to go forward.</div>Looking forwards for your reply.<br><br>Thanks<br>Junita<br><br>/*************** Screen dump ********************/<br><div class="MsoPlainText"># f<span style="font-weight: bold;">disk /dev/xsysace</span><o:p></o:p></div>  <div class="MsoPlainText">1. sector = 0 xsa_cur_req-&gt;sector=0<o:p></o:p></div>  <div class="MsoPlainText">System ACE: Error 0 when reading sector 2.<o:p></o:p></div>  <div class="MsoPlainText">2. sector = 2 xsa_cur_req-&gt;sector=16<o:p></o:p></div>  <div class="MsoPlainText">end_request: I/O error, System ACE: Error 0 when reading sectoru dev xsa, sector 16<o:p></o:p></div> 
 <div class="MsoPlainText">Buffer I/O error on device xsa, logical block 2<o:p></o:p></div>  <div class="MsoPlainText">1. sector = 184 xsa_cur_req-&gt;sector=184<o:p></o:p></div>  <div class="MsoPlainText"><o:p>&nbsp;</o:p></div>  <div class="MsoPlainText">Command (m for help): p<o:p></o:p></div>  <div class="MsoPlainText"><o:p>&nbsp;</o:p></div>  <div class="MsoPlainText">Disk /dev/xsysace: 524 MB, 524869632 bytes<o:p></o:p></div>  <div class="MsoPlainText">17 heads, 59 sectors/track, 1022 cylinders<o:p></o:p></div>  <div class="MsoPlainText">Units = cylinders of 1003 * 512 = 513536 bytes<o:p></o:p></div>  <div class="MsoPlainText"><o:p>&nbsp;</o:p></div>  <div class="MsoPlainText"><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Device Boot<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Start<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>End<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Blocks<span style="">&nbsp;&nbsp;
 </span>Id<span style="">&nbsp; </span>System<o:p></o:p></div>  <div class="MsoPlainText">/dev/xsysace1<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>1<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>1022<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>512503+<span style="">&nbsp;&nbsp; </span>6<span style="">&nbsp; </span>FAT16<o:p></o:p></div>  <div class="MsoPlainText"><o:p>&nbsp;</o:p></div>  <div class="MsoPlainText">Command (m for help): q<o:p></o:p></div>    <span style="font-weight: bold;">And for 'mount'</span><o:p></o:p>  <div class="MsoPlainText">#<o:p></o:p></div>  <div class="MsoPlainText">#<o:p></o:p></div>  <div class="MsoPlainText"><span style="font-weight: bold;"># mount -t msdos /dev/xsysace /root/cf</span><o:p></o:p></div>  <div class="MsoPlainText">1. sector = 0 xsa_cur_req-&gt;sector=0<o:p></o:p></div>  <div class="MsoPlainText">1. sector = 503
 xsa_cur_req-&gt;sector=503<o:p></o:p></div>  <div class="MsoPlainText">1. sector = 504 xsa_cur_req-&gt;sector=504<o:p></o:p></div>  <div class="MsoPlainText">1. sector = 506 xsa_cur_req-&gt;sector=506<o:p></o:p></div>  <div class="MsoPlainText">1. sector = 508 xsa_cur_req-&gt;sector=508<o:p></o:p></div>  <div class="MsoPlainText">1. sector = 510 xsa_cur_req-&gt;sector=510<o:p></o:p></div>  <div class="MsoPlainText"># cd /root/cf<o:p></o:p></div>  <div class="MsoPlainText">&lt; Here Prints Some Symbols like + - etc, which i am<o:p></o:p></div>  <div class="MsoPlainText"><span style="">&nbsp; </span>not able to capture/copy -------------ERROR<o:p></o:p></div>  <div class="MsoPlainText">b: No such file or directory--------------------------------ERROR<o:p></o:p></div>  <div class="MsoPlainText">pci.h<o:p></o:p></div>  <div class="MsoPlainText">#<o:p></o:p></div>  <div
 class="MsoPlainText">Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.n0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.d#<o:p></o:p></div>  <div class="MsoPlainText"># cp pci.h /root/<o:p></o:p></div>  <div class="MsoPlainText"># cd ../<o:p></o:p></div>  <div class="MsoPlainText"># ls<o:p></o:p></div>  <div class="MsoPlainText">app<span style="">&nbsp;&nbsp;&nbsp;&nbsp; </span>cf<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>hello1<span style="">&nbsp; </span>pci.h<o:p></o:p></div>    <div class="MsoPlainText">#<o:p></o:p></div>  <div class="MsoPlainText">#/root<o:p></o:p></div>  <div class="MsoPlainText"><span style="">&nbsp;</span>/dev/xsysace /root/cf<o:p></o:p></div>  <div class="MsoPlainText">FAT: bogus number of reserved sectors<o:p></o:p></div>  <div class="MsoPlainText">VFS: Can't find a valid FAT
 filesystem on dev xsa.<o:p></o:p></div>  <div class="MsoPlainText">mount: Mounting /dev/xsysace on /root/cf failed: Invalid argument<o:p></o:p></div>  <div class="MsoPlainText">#<o:p></o:p></div>  <div class="MsoPlainText"><o:p>&nbsp;</o:p></div>  <br><br><pre><br><i><i><br><br><br><br></i></i></pre><br><p>&#32;
	

	
		<hr size=1></hr> 
Find out what India is talking about on  - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> 
Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <a href="http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Get it NOW</a>
--0-1757925272-1158705829=:24624--
