Return-Path: <bharthik2004@yahoo.com>
Message-ID: <20060120063052.52505.qmail@web50008.mail.yahoo.com>
Date: Thu, 19 Jan 2006 22:30:52 -0800 (PST)
From: bharathi kandimalla <bharthik2004@yahoo.com>
Subject: serial driver for MPC860T  in linux 2.6.13
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-702085885-1137738652=:51579"
Cc: jagadish <jagadish@india.advinfo.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-702085885-1137738652=:51579
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

  Hi
   We are able to port the linux 2.6 in our target board.As the 
MPC860T has 4 SCC  ports and two SMC ports.I want to up all the SMC and SCC
 ports.When I am selecting all the options in the kernel configuration
 It is getting hanged.
 I did n't see any mknod in the code
  how can I know  ttyCPM2 is for SMC2.At the time of ramdisk building I have created the the softlink to ttyCPM2 ->console
   ttyCPM1 is for SMC1  like that
   and they mentioned only major number is 204 minor number is 46
    As we  want to use 6 ports.We want 6 minor numbers
   
   when I am selectind SMC  and all  SCC' s  the o.s is up in the target board( as the program did not have any portpin configuartions for the SCC's)
   when I am selecting SMC1 and SMC2 it is getting hanged
  
 regards
  Bharathi



			
---------------------------------
Yahoo! Photos
 Got holiday prints? See all the ways to get quality prints in your hands ASAP.
--0-702085885-1137738652=:51579
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>  <DIV>Hi<BR>&nbsp;&nbsp; We are able to port the linux 2.6 in our target board.As the <BR>MPC860T has 4 SCC&nbsp; ports and two SMC ports.I want to up all the SMC and SCC<BR>&nbsp;ports.When I am selecting all the options in the kernel configuration<BR>&nbsp;It is getting hanged.<BR>&nbsp;I did n't see any mknod in the code<BR>&nbsp; how can I know&nbsp; ttyCPM2 is for SMC2.At the time of ramdisk building I&nbsp;have created the the softlink to&nbsp;ttyCPM2&nbsp;-&gt;console<BR>&nbsp;&nbsp;&nbsp;ttyCPM1 is for SMC1&nbsp; like that<BR>&nbsp;&nbsp;&nbsp;and they mentioned only major number is 204 minor number is 46</DIV>  <DIV>&nbsp; As we&nbsp; want to use 6 ports.We want 6 minor numbers</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;when I am selectind SMC  and all&nbsp; SCC' s&nbsp; the&nbsp;o.s is up in the target board( as&nbsp;the program did not have any portpin configuartions for the SCC's)</DIV>  <DIV>&nbsp;when I am selecting SMC1 and SMC2 it is getting hanged</DIV>
  <DIV><BR>&nbsp;regards</DIV>  <DIV>Bharathi<BR></DIV></DIV><p>
	
		<hr size=1>Yahoo! Photos<br> 
Got holiday prints? <a href="http://us.rd.yahoo.com/mail_us/taglines/holidayprints/*http://pa.yahoo.com/*http://us.rd.yahoo.com/mail_us/taglines/photos/evt=38089/*http://pg.photos.yahoo.com/ph//print_splash">See all the ways</a> to get quality prints in your hands ASAP.
--0-702085885-1137738652=:51579--
