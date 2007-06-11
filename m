Return-Path: <chenxurcy@yahoo.com.cn>
Received: from web92009.mail.cnb.yahoo.com (web92009.mail.cnb.yahoo.com
	[203.209.230.56]) by ozlabs.org (Postfix) with SMTP id 37F91DDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Jun 2007 12:54:22 +1000 (EST)
Date: Mon, 11 Jun 2007 10:47:40 +0800 (CST)
From: xu chen <chenxurcy@yahoo.com.cn>
Subject: opb_ethernet driver
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2010683304-1181530060=:63061"
Message-ID: <452567.63061.qm@web92009.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2010683304-1181530060=:63061
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit


Hello.
      I'm porting an opb_ethernet driver to my ml403 board now, using the 2.6.17 kernel. I know the ethernet support 3 mode: No DMA, simple DMA, scatter gather DMA, when I use the No DMA mode, we can write the skb into the FIFO, but can't ping other PCs in the network. When I use the simple DMA mode, at the time of ping, in the driver, we should initialize the DMA channel, but when transfering the skb, the DMA returns a "DMA bus time out" signal.
     Now I'm worry about it. Who had encountered the problem before? I think I need some help.




       
---------------------------------
ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä3.5GÈÝÁ¿£¬20M¸½¼þ£¡ 
--0-2010683304-1181530060=:63061
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<pre><tt><tt><a href="Compose?To=linuxppc-embedded@ozlabs.org&amp;YY=88037&amp;order=down&amp;sort=date&amp;pos=0">Hello.<br>      I'm porting an opb_ethernet driver to my ml403 board now, using the 2.6.17 kernel. I know the ethernet support 3 mode: No DMA, simple DMA, scatter gather DMA, when I use the No DMA mode, we can write the skb into the FIFO, but can't ping other PCs in the network. When I use the simple DMA mode, at the time of ping, in the driver, we should initialize the DMA channel, but when transfering the skb, the DMA returns a "DMA bus time out" signal.<br>     Now I'm worry about it. Who had encountered the problem before? I think I need some help.<br></a></tt></tt></pre><BR><BR><p>&#32;



      <hr size=1><a href="http://cn.mail.yahoo.com" target=blank>ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä3.5GÈÝÁ¿£¬20M¸½¼þ£¡</a> 
--0-2010683304-1181530060=:63061--
