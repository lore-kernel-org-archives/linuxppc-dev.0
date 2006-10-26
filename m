Return-Path: <vantranbk@yahoo.com.au>
Received: from web33012.mail.mud.yahoo.com (web33012.mail.mud.yahoo.com
	[209.191.69.127]) by ozlabs.org (Postfix) with SMTP id 816BF67CCC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 19:50:35 +1000 (EST)
Message-ID: <20061026095033.85887.qmail@web33012.mail.mud.yahoo.com>
Date: Thu, 26 Oct 2006 19:50:33 +1000 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: Linux-2.6.x for TQM860L
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-419931175-1161856233=:66158"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-419931175-1161856233=:66158
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi WolfgangDenk
  I have just read pages
  http://www.denx.de/wiki/Know/Linux24vs26 and i see you had build Linux-2.6.11.7 for TQM860L with instruction below 
  Download  Kernel Version 2.6.11.7 from kernel.org plus 8xx v2.6 TLB patch by Marcelo Tosatti (4 Apr 2005)
  Download config-2.6.11.7-TQM860L
  Build instruction

-> export CROSS_COMPILE=ppc_8xx-  -> cp ../config-2.6.11.7-TQM860L .config  -> make ARCH=ppc CROSS_COMPILE=ppc_8xx- oldconfig  -> time make -j8 ARCH=ppc CROSS_COMPILE=ppc_8xx- uImage
   
  I had done exactly these intruction but I received error 
  Why? Had I missed another guide?
  Thanks
   
  LeVan  

 		
---------------------------------
Do you Yahoo!?
  Help K-Zone create the longest line of footprints and break a world record
--0-419931175-1161856233=:66158
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi <A class=twikiLink href="http://www.denx.de/wiki/Main/WolfgangDenk">WolfgangDenk</A></div>  <div>I have just read pages</div>  <div><A href="http://www.denx.de/wiki/Know/Linux24vs26">http://www.denx.de/wiki/Know/Linux24vs26</A>&nbsp;and i see you had build Linux-2.6.11.7 for TQM860L with instruction below </div>  <div>Download &nbsp;Kernel <A href="ftp://ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.7.tar.bz2" target=_top>Version 2.6.11.7 from kernel.org</A> plus <A href="http://www.denx.de/wiki/pub/Know/Linux24vs26/tosatti.patch" target=_top>8xx v2.6 TLB patch by Marcelo Tosatti (4 Apr 2005)</A></div>  <div>Download <A href="http://www.denx.de/wiki/pub/Know/Linux24vs26/config-2.6.11.7-TQM860L" target=_top>config-2.6.11.7-TQM860L</A></div>  <div>Build instruction</div><PRE>-&gt; export CROSS_COMPILE=ppc_8xx-  -&gt; cp ../config-2.6.11.7-TQM860L .config  -&gt; make ARCH=ppc CROSS_COMPILE=ppc_8xx- oldconfig  -&gt; time make -j8 ARCH=ppc CROSS_COMPILE=ppc_8xx-
 uImage</PRE>  <div>&nbsp;</div>  <div>I had done exactly these intruction but I received error </div>  <div>Why? Had I missed&nbsp;another guide?</div>  <div>Thanks</div>  <div>&nbsp;</div>  <div>LeVan&nbsp;&nbsp;</div><p>&#32;
		<hr size=1>Do you Yahoo!?<br> 
<a 
href="http://au.rd.yahoo.com/mail/tag/kzone/SIG=12vv1ch5j/**http%3A%2F%2Fwww.kzone.com.au%2Fdisplay.cfm%3FObjectID%3DFB378E31-10DA-493F-B97AE3065F22180E"> 
Help K-Zone create the longest line of footprints and break a world record</a>
--0-419931175-1161856233=:66158--
