Return-Path: <chenxurcy@yahoo.com.cn>
Received: from web92006.mail.cnb.yahoo.com (web92006.mail.cnb.yahoo.com
	[203.209.230.53]) by ozlabs.org (Postfix) with SMTP id D73E3DDEE0
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 12:44:37 +1000 (EST)
Date: Mon, 11 Jun 2007 10:37:55 +0800 (CST)
From: xu chen <chenxurcy@yahoo.com.cn>
Subject: opb_ethernet driver
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1396264439-1181529475=:22723"
Message-ID: <22250.22723.qm@web92006.mail.cnb.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1396264439-1181529475=:22723
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello.
      I'm porting an opb_ethernet driver to my ml403 board now, using the 2.6.17 kernel. I know the ethernet support 3 mode: No DMA, simple DMA, scatter gather DMA, when I use the No DMA mode, we can write the skb into the FIFO, but can't ping other PCs in the network. When I use the simple DMA mode, at the time of ping, in the driver, we should initialize the DMA channel, but when transfering the skb, the DMA returns a "DMA bus time out" signal. 
     Now I'm worry about it. Who had encountered the problem before? I think I need some help.

 		
---------------------------------
 ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ
--0-1396264439-1181529475=:22723
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I'm porting an opb_ethernet driver to my ml403 board now, using the 2.6.17 kernel. I know the ethernet support 3 mode: No DMA, simple DMA, scatter gather DMA, when I use the No DMA mode, we can write the skb into the FIFO, but can't ping other PCs in the network. When I use the simple DMA mode, at the time of ping, in the driver, we should initialize the DMA channel, but when transfering the skb, the DMA returns a "DMA bus time out" signal. <br>&nbsp;&nbsp;&nbsp;&nbsp; Now I'm worry about it. Who had encountered the problem before? I think I need some help.<br><p>&#32;
		<hr size=1><a href="http://cn.mail.yahoo.com/" target=blank> 
ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ</a>
--0-1396264439-1181529475=:22723--
