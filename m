Return-Path: <kelvin_q_lin@yahoo.com>
Received: from n79.bullet.mail.sp1.yahoo.com (n79.bullet.mail.sp1.yahoo.com
	[98.136.44.39]) by ozlabs.org (Postfix) with SMTP id 658FFDDF75
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 12:54:17 +1100 (EST)
Date: Thu, 27 Mar 2008 09:54:16 +0800 (CST)
From: Kelvin Lin <kelvin_q_lin@yahoo.com>
Subject: =?gb2312?q?=BB=D8=B8=B4=A3=BA=20Could=20PowerPC(IBM=20power=20blade,
	=20js?= =?gb2312?q?=2021,=208844)=20boot=20via=20usb=20key=3F?=
To: linuxppc-dev@ozlabs.org
In-Reply-To: <680109.97825.qm@web45304.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-867930949-1206582856=:9150"
Message-ID: <671479.9150.qm@web45314.mail.sp1.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-867930949-1206582856=:9150
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Does anyone know about it?
   
  Thanks a lot.

Kelvin Lin <kelvin_q_lin@yahoo.com> –¥µ¿£∫
    Hi guys,
   
  I created a PReP partition in usb key and then did "dd" and something like that to configure yaboot on it.
   
  But the key point is that, when I boot power blade, there is not usb key in the bootable list. I mean, there are just:
   1.        -      Ethernet
                  ( loc=U788D.001.99DXC6K-P1-T7 )
 2.        -      Ethernet
                  ( loc=U788D.001.99DXC6K-P1-T8 )
 3.        -      USB CD-ROM
                  ( loc=U788D.001.99DXC6K-P1-T1-L1-L3 )
 4.        1      SCSI 36401 MB Harddisk, part=1 ()
                  ( loc=U788D.001.99DXC6K-P1-T10-L1-L0 )
   
  My usb key is Kingston's DataTraveler 2GB.
   
  Then I change another Sandisk cruzer 2GB usb key, it shows as follows in the boot menu:
   
   1.        -      Ethernet
                  ( loc=U788D.001.99DXC6K-P1-T7 )
 2.        -      Ethernet
                  ( loc=U788D.001.99DXC6K-P1-T8 )
 3.        -      USB CD-ROM
                  ( loc=U788D.001.99DXC6K-P1-T1-L1-L3 )
 4.        1      SCSI 36401 MB Harddisk, part=1 ()
                  ( loc=U788D.001.99DXC6K-P1-T10-L1-L0 )
 5.        -      USB CD-ROM
                  ( loc=U788D.001.99DXC6K-P1-T1-L1-L2-L1-L0 )

  But this item 5 USB CD-ROM is simulated by Sandisk, not the actual usb key. I can't boot my server via item 5.
   
  Could IBM power blade, js 21, 8844 boot via usb key? If not, could you please provide official doc to prove it. Because I have to persuade my boss to give up it. -:)
   
  Any comment is appreciated. Thanks a lot in advanced.
   
  Kelvin.
    
---------------------------------
  —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

       
---------------------------------
 —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°
--0-867930949-1206582856=:9150
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<div>Does&nbsp;anyone know about it?</div>  <div>&nbsp;</div>  <div>Thanks a lot.<BR><BR><B><I>Kelvin Lin &lt;kelvin_q_lin@yahoo.com&gt;</I></B> –¥µ¿£∫</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">  <DIV>Hi guys,</DIV>  <DIV>&nbsp;</DIV>  <DIV>I created a PReP partition in usb key and then did "dd" and something like that to configure yaboot on it.</DIV>  <DIV>&nbsp;</DIV>  <DIV>But the key point is that, when I boot power blade, there is not usb key in the bootable list. I mean, there are just:</DIV>  <DIV>&nbsp;1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ethernet<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T7 )<BR>&nbsp;2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 Ethernet<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T8 )<BR>&nbsp;3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB CD-ROM<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T1-L1-L3 )<BR>&nbsp;4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCSI 36401 MB Harddisk, part=1 ()<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T10-L1-L0 )</DIV>  <DIV>&nbsp;</DIV>  <DIV>My usb key is Kingston's DataTraveler 2GB.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Then I change another Sandisk cruzer 2GB usb key, it shows as follows in the boot menu:</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 Ethernet<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T7 )<BR>&nbsp;2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ethernet<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T8 )<BR>&nbsp;3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB CD-ROM<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T1-L1-L3 )<BR>&nbsp;4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCSI 36401 MB Harddisk, part=1 ()<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T10-L1-L0 )<BR>&nbsp;5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB
 CD-ROM<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T1-L1-L2-L1-L0 )<BR></DIV>  <DIV>But this&nbsp;item 5&nbsp;USB CD-ROM is simulated by Sandisk, not the actual usb key. I can't boot my server via item 5.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Could IBM power blade, js 21, 8844 boot via usb key? If not, could you please provide official doc to prove it. Because I have to persuade my boss to give up it. -:)</DIV>  <DIV>&nbsp;</DIV>  <DIV>Any comment is appreciated. Thanks a lot in advanced.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Kelvin.</DIV>  <div>  <HR SIZE=1>  <A href="http://cn.mail.yahoo.com/">—≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°</A>_______________________________________________<BR>Linuxppc-dev mailing list<BR>Linuxppc-dev@ozlabs.org<BR>https://ozlabs.org/mailman/listinfo/linuxppc-dev</BLOCKQUOTE><BR><p>&#32;


      <hr size=1><a href="http://cn.mail.yahoo.com/"> —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°</a>
--0-867930949-1206582856=:9150--
