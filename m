Return-Path: <paravpandit@yahoo.com>
Message-ID: <20060819065247.10235.qmail@web36608.mail.mud.yahoo.com>
Date: Fri, 18 Aug 2006 23:52:47 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: ioremap() twice on same memory mapped area?
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2039895730-1155970367=:9676"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2039895730-1155970367=:9676
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  I have memory mapped device and two device drivers wants to use the same area for different external device.
  To access the same space there is a global spin lock to avoid any race condition.
   
  Question is:
  Can both the driver call the ioremap() on the same space and get the different virtual address? or ioremap() should fail?
   
  Regards,
  Parav Pandit
   

 		
---------------------------------
Get your email and more, right on the  new Yahoo.com 
--0-2039895730-1155970367=:9676
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>I have memory mapped device and two device drivers wants to use the same area for different external device.</div>  <div>To access the same space there is a global spin lock to avoid any race condition.</div>  <div>&nbsp;</div>  <div>Question is:</div>  <div>Can both the driver call the ioremap() on the same space and get the different virtual address? or ioremap() should fail?</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Parav Pandit</div>  <div>&nbsp;</div><p>&#32;
		<hr size=1>Get your email and more, right on the <a href="http://us.rd.yahoo.com/evt=42973/*http://www.yahoo.com/preview"> new Yahoo.com</a> 

--0-2039895730-1155970367=:9676--
