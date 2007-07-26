Return-Path: <cmoszhang@yahoo.com.cn>
Received: from web15210.mail.cnb.yahoo.com (web15210.mail.cnb.yahoo.com
	[202.165.105.140]) by ozlabs.org (Postfix) with SMTP id 8C32CDDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 18:04:45 +1000 (EST)
Date: Thu, 26 Jul 2007 15:58:04 +0800 (CST)
From: =?gb2312?q?=C0=FB=C6=BD=20=D5=C5?= <cmoszhang@yahoo.com.cn>
Subject: i have a question about:ppc pci and frame_buffer
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-27569218-1185436684=:18053"
Message-ID: <749612.18053.qm@web15210.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-27569218-1185436684=:18053
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

now i have a question:
  i know ppc is big_endian and pci bus is little_endian.i made a graphics pci card use big_endian.
  when i use graphics card to show QT 's picture through VGA ,the color is not what i wanted, it's inversed ,others are in right position.
  here below is what i want :
  #################################################
  0..................7  8............15 16..............24 25.................31 
           B                    G                   R                TRANS
  now it is this:
  #################################################
  0..................7  8............15 16..............24 25.................31 
        TRANS               R                   G                   B
  #################################################
   
  through mmap, the ppc display the screen color through direct pci bus control ,how can i change it?? 
  change kernel?? (i don't know where to change)
  or change others?? 

       
---------------------------------
ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä3.5GÈÝÁ¿£¬20M¸½¼þ£¡ 
--0-27569218-1185436684=:18053
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<div>now i have a question:</div>  <div>i know ppc is big_endian and pci bus is little_endian.i made a graphics pci card use big_endian.</div>  <div>when i use graphics card to show QT 's picture through VGA ,the color is not what i wanted,&nbsp;it's&nbsp;inversed ,others are in right position.</div>  <div>here below is what i want :</div>  <div>#################################################</div>  <div>0..................7&nbsp; 8............15 16..............24 25.................31 </div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TRANS</div>  <div>now it is this:</div> 
 <div>#################################################</div>  <div>0..................7&nbsp; 8............15 16..............24 25.................31 </div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TRANS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B</div>  <div>#################################################</div>  <div>&nbsp;</div>  <div>through&nbsp;mmap, the ppc display the&nbsp;screen color through direct pci bus control ,how can i change it??&nbsp;</div>  <div>change kernel?? (i don't know where to change)</div>  <div>or change others?? </div><p>&#32;



      <hr size=1><a href="http://cn.mail.yahoo.com" target=blank>ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä3.5GÈÝÁ¿£¬20M¸½¼þ£¡</a> 
--0-27569218-1185436684=:18053--
