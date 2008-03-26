Return-Path: <kelvin_q_lin@yahoo.com>
Received: from n73b.bullet.mail.sp1.yahoo.com (n73b.bullet.mail.sp1.yahoo.com
	[98.136.45.46]) by ozlabs.org (Postfix) with SMTP id A7087DDFF5
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 20:47:25 +1100 (EST)
Date: Wed, 26 Mar 2008 17:41:47 +0800 (CST)
From: Kelvin Lin <kelvin_q_lin@yahoo.com>
Subject: Could PowerPC(IBM power blade, js 21, 8844) boot via usb key?
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-801111233-1206524507=:97825"
Message-ID: <680109.97825.qm@web45304.mail.sp1.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-801111233-1206524507=:97825
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

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
 —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°
--0-801111233-1206524507=:97825
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<div>Hi guys,</div>  <div>&nbsp;</div>  <div>I created a PReP partition in usb key and then did "dd" and something like that to configure yaboot on it.</div>  <div>&nbsp;</div>  <div>But the key point is that, when I boot power blade, there is not usb key in the bootable list. I mean, there are just:</div>  <div>&nbsp;1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ethernet<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T7 )<BR>&nbsp;2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ethernet<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T8 )<BR>&nbsp;3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB CD-ROM<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (
 loc=U788D.001.99DXC6K-P1-T1-L1-L3 )<BR>&nbsp;4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCSI 36401 MB Harddisk, part=1 ()<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T10-L1-L0 )</div>  <div>&nbsp;</div>  <div>My usb key is Kingston's DataTraveler 2GB.</div>  <div>&nbsp;</div>  <div>Then I change another Sandisk cruzer 2GB usb key, it shows as follows in the boot menu:</div>  <div>&nbsp;</div>  <div>&nbsp;1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ethernet<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T7 )<BR>&nbsp;2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ethernet<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T8
 )<BR>&nbsp;3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB CD-ROM<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T1-L1-L3 )<BR>&nbsp;4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCSI 36401 MB Harddisk, part=1 ()<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T10-L1-L0 )<BR>&nbsp;5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB CD-ROM<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( loc=U788D.001.99DXC6K-P1-T1-L1-L2-L1-L0 )<BR></div>  <div>But this&nbsp;item 5&nbsp;USB CD-ROM is simulated by Sandisk, not the actual usb key. I can't boot my server via item 5.</div>  <div>&nbsp;</div>  <div>Could IBM power blade, js 21, 8844 boot via usb key? If not,
 could you please provide official doc to prove it. Because I have to persuade my boss to give up it. -:)</div>  <div>&nbsp;</div>  <div>Any comment is appreciated. Thanks a lot in advanced.</div>  <div>&nbsp;</div>  <div>Kelvin.</div><p>&#32;


      <hr size=1><a href="http://cn.mail.yahoo.com/"> —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°</a>
--0-801111233-1206524507=:97825--
