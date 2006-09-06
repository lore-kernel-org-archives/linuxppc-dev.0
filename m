Return-Path: <paravpandit@yahoo.com>
Received: from web36603.mail.mud.yahoo.com (web36603.mail.mud.yahoo.com
	[209.191.85.20]) by ozlabs.org (Postfix) with SMTP id 52DEE67B87
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 18:43:48 +1000 (EST)
Message-ID: <20060906084346.20669.qmail@web36603.mail.mud.yahoo.com>
Date: Wed, 6 Sep 2006 01:43:46 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: __init() and module_init() serialization of modules?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-16107255-1157532226=:20343"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-16107255-1157532226=:20343
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  My doubt is more related to Linux kernel rather than PPC, but I feel that many will be interested to know this. Please help me to understand a silly doubt.
   
  When we have drivers as kernel modules, it can be loaded using insmod or modprobe.
  We use the depmod utility to generate the module dependancy and so concerned module gets loaded first.
  This is fine.
   
  Now when in comes to in-build module (part of kernel image), we obviously don't run the modprobe and/or depmod because they are no more modules.
   
  So how does - during compilation time, tool chain can identify which module to load first so that do_initcalls() function can take care if it.
   
  e.g. Module A and Module B.
  Both are inbuild, and A uses the functionality of B. So module_init() of B should get called first.
  How this is achieved for in-build modules?
  __init macro takes care of it for freeing that memory after those calls, but how the sequencing is done?
   
  Regards,
  Parav Pandit
   

 		
---------------------------------
Stay in the know. Pulse on the new Yahoo.com.  Check it out. 
--0-16107255-1157532226=:20343
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>My doubt is more related to Linux kernel rather than PPC, but I feel that many will be interested to know this. Please help me to understand a silly doubt.</div>  <div>&nbsp;</div>  <div>When we have drivers as kernel modules, it can be loaded using insmod or modprobe.</div>  <div>We use the depmod utility to generate the module dependancy and so&nbsp;concerned module gets loaded first.</div>  <div>This is fine.</div>  <div>&nbsp;</div>  <div>Now when in comes to in-build module (part of kernel image), we obviously don't run the modprobe and/or depmod because they are no more modules.</div>  <div>&nbsp;</div>  <div>So how does - during compilation time, tool chain can identify which module to load first so that do_initcalls() function can take care if it.</div>  <div>&nbsp;</div>  <div>e.g. Module A and Module B.</div>  <div>Both are inbuild, and A uses the functionality of B. So module_init() of B should get called first.</div> 
 <div>How this is achieved for in-build modules?</div>  <div>__init macro takes care of it for freeing that memory after those calls, but how the sequencing is done?</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Parav Pandit</div>  <div>&nbsp;</div><p>&#32;
		<hr size=1>Stay in the know. Pulse on the new Yahoo.com. <a href="http://us.rd.yahoo.com/evt=42974/*http://www.yahoo.com/preview"> Check it out.</a> 

--0-16107255-1157532226=:20343--
