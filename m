Return-Path: <david_xtao@yahoo.com>
Message-ID: <20060118012837.70518.qmail@web32113.mail.mud.yahoo.com>
Date: Tue, 17 Jan 2006 17:28:37 -0800 (PST)
From: David Tao <david_xtao@yahoo.com>
Subject: Question about SCC Ethernet driver
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-779519923-1137547717=:65944"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-779519923-1137547717=:65944
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello there,
   
  Present MPC8260 SCC Ethernet driver supports one 10M Ethernet port for SCC1 or SCC2. And there is a patch on the net said to support one Ethernet port on any of SCC1 - SCC4. As we hope to use all the SCCs for 10M Ethernet ports, we need to change the driver. Questions:
   
  1. Is it possible to implement 7 Ethernet ports (3 FCCs and 4 SCCs) on a MPC8270? I didn't see any hardware restriction on this. Performance may be an issue? 
  2. Is there a driver which supports multiple SCC Ethernet ports simultanously?
   
  Thanks for any help or information.
   
  Regards,
  David
   

			
---------------------------------
Yahoo! Photos
 Got holiday prints? See all the ways to get quality prints in your hands ASAP.
--0-779519923-1137547717=:65944
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>Hello there,</DIV>  <DIV>&nbsp;</DIV>  <DIV>Present MPC8260 SCC Ethernet driver supports&nbsp;one 10M Ethernet port for SCC1 or SCC2. And there is a patch on the net said to support one Ethernet port on any of SCC1 - SCC4. As we hope to&nbsp;use all the SCCs for 10M Ethernet ports, we&nbsp;need to&nbsp;change the driver. Questions:</DIV>  <DIV>&nbsp;</DIV>  <DIV>1. Is it possible to&nbsp;implement 7 Ethernet ports (3 FCCs and 4 SCCs) on a MPC8270? I didn't see any hardware restriction on this. Performance may be an issue?&nbsp;</DIV>  <DIV>2. Is there a driver which supports multiple SCC Ethernet ports simultanously?</DIV>  <DIV>&nbsp;</DIV>  <DIV>Thanks for any help or information.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Regards,</DIV>  <DIV>David</DIV>  <DIV>&nbsp;</DIV><p>
	
		<hr size=1>Yahoo! Photos<br> 
Got holiday prints? <a href="http://us.rd.yahoo.com/mail_us/taglines/holidayprints/*http://pa.yahoo.com/*http://us.rd.yahoo.com/mail_us/taglines/photos/evt=38089/*http://pg.photos.yahoo.com/ph//print_splash">See all the ways</a> to get quality prints in your hands ASAP.
--0-779519923-1137547717=:65944--
