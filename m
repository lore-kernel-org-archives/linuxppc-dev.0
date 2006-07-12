Return-Path: <yousuf_incet@yahoo.co.in>
Received: from web8401.mail.in.yahoo.com (web8401.mail.in.yahoo.com
	[202.43.219.149]) by ozlabs.org (Postfix) with SMTP id 098AD679E1
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 14:57:30 +1000 (EST)
Message-ID: <20060712045049.88457.qmail@web8401.mail.in.yahoo.com>
Date: Tue, 11 Jul 2006 21:50:49 -0700 (PDT)
From: Yousuf <yousuf_incet@yahoo.co.in>
Subject: SMI501 chip help required !!!!
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-15229804-1152679849=:75381"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-15229804-1152679849=:75381
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
    I am doing a driver development project for the display chip SMI501. I saw some postings on this chip on this mailing group so thought you pepole can help me. 

BCKGND: The 501 chip is connected on the intel XScale PXA 255 (ARM v5) processor. Our requirement is to enable the additional hardware layers within the 501 chip and give a fb device for each layer. Code is available for enabling single layer.I have modified the code to register the video layer and alpha layer part by setting the registers. The three layers are working fine and the alpha transparency etc are working fine. Now the problem is of flicker :(   

FIXME: When i enable all the three layers (Panel + Video + Alpha) the image flickers to the right end. And usually this happens in the intersecting area of alpha and video layer. The image seems to be overdrawn fastly with correct data ( data supposed to come on that part of the display) and a shifted pixel data from some what 3/4th of the screen. i.e if we are seeing a tux in the fb console, with the rest of the display part along the tux as black, the intersection region will be seen as the tux shifted to the right with black lines and the tux image redrawing one on top of the other fastly. 

TRIES:     We have 8Mb of video memory and I tried changing the buffer offsets of the layer, but it didnt work. One more thing is that when i changed the resolution of the panel graphics to 1024x768, enabling even a single layer ended up with flicker. Also when i changed resolution to 640x480, enabling the layers didnt cause any problem. But our requirement is of 800x600 resolution. I suspect this as a monitor timing issue.  I tried chainging the monitor refresh rate to 75Hz (800x600 res). Even then the problem is there but the redraw is too fast.

HELP: I think that the hardware draws each line seperatley for each layer one after the other or else how can the correct data and the incorrect date be redrawn on the same location. Please correct me if am wrong and help me in this situation. Thanks in advance :))

Regards
Yousuf A

Thanks,
Yousuf
 		
---------------------------------
Do you Yahoo!?
 Everyone is raving about the  all-new Yahoo! Mail Beta.
--0-15229804-1152679849=:75381
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br>&nbsp;&nbsp; &nbsp;I am doing a driver development project for the display chip SMI501. I saw some postings on this chip on this mailing group so thought you pepole can help me. <br><br>BCKGND: The 501 chip is connected on the intel XScale PXA 255 (ARM v5) processor. Our requirement is to enable the additional hardware layers within the 501 chip and give a fb device for each layer. Code is available for enabling single layer.I have modified the code to register the video layer and alpha layer part by setting the registers. The three layers are working fine and the alpha transparency etc are working fine. Now the problem is of flicker :(&nbsp; &nbsp;<br><br>FIXME: When i enable all the three layers (Panel + Video + Alpha) the image flickers to the right end. And usually this happens in the intersecting area of alpha and video layer. The image seems to be overdrawn fastly with correct data ( data supposed to come on that part of the display) and a shifted pixel data
 from some what 3/4th of the screen. i.e if we are seeing a tux in the fb console, with the rest of the display part along the tux as black, the intersection region will be seen as the tux shifted to the right with black lines and the tux image redrawing one on top of the other fastly. <br><br>TRIES: &nbsp;&nbsp; &nbsp;We have 8Mb of video memory and I tried changing the buffer offsets of the layer, but it didnt work. One more thing is that when i changed the resolution of the panel graphics to 1024x768, enabling even a single layer ended up with flicker. Also when i changed resolution to 640x480, enabling the layers didnt cause any problem. But our requirement is of 800x600 resolution. I suspect this as a monitor timing issue.&nbsp; I tried chainging the monitor refresh rate to 75Hz (800x600 res). Even then the problem is there but the redraw is too fast.<br><br>HELP: I think that the hardware draws each line seperatley for each layer one after the other or else how can
 the correct data and the incorrect date be redrawn on the same location. Please correct me if am wrong and help me in this situation. Thanks in advance :))<br><br>Regards<br>Yousuf A<BR><BR>Thanks,<br>Yousuf<p>&#32;
		<hr size=1>Do you Yahoo!?<br> Everyone is raving about the <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/handraisers"> all-new Yahoo! Mail Beta.</a>
--0-15229804-1152679849=:75381--
