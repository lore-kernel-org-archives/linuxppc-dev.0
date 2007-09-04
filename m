Return-Path: <chenxurcy@yahoo.com.cn>
Received: from n10a.bullet.mail.re3.yahoo.com (n10a.bullet.mail.re3.yahoo.com
	[68.142.236.51]) by ozlabs.org (Postfix) with SMTP id 41AA8DDE09
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 11:37:48 +1000 (EST)
Date: Tue, 4 Sep 2007 09:31:24 +0800 (CST)
From: xu chen <chenxurcy@yahoo.com.cn>
Subject: Please help me with my opb_ethernet driver!!!
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-518570467-1188869484=:87879"
Message-ID: <674410.87879.qm@web15603.mail.cnb.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-518570467-1188869484=:87879
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

I have used ml403 reference board recently, and now I am porting the opb_ethernet driver downloaded from the net onto the board. I use the EDK9.1 developing environment, and the driver files like "xemac.c" are copied from the EDK drivers lib. My opb_ethernet driver can work in the "No DMA mode", but the speed of FIFO is too slow to transport big files. So I transfer to "Simple DMA mode". I configured the hardware IP core in the EDK, in details, I only changed the DMA mode of opb_ethernet IP core to "Simple DMA", and then synthesize the hardware again. After that I recompile the kernel of the new xparameters.h file. But when I ping the board, in the Recv ISR function, the result of DMA operation from Recv FIFO to kernel memory is always "DMA timed out". I checked the pdf of opb_ethernet and the ipif, but I can't find any problem, especially the manner of DMA. I can only guess that there are some problems in the hardware configuration, so who can help me about that problem?
 Thank you very much.

       
---------------------------------
 —≈ª¢√‚∑—” œ‰£¨»´«Úµ⁄“ª” œ‰∆∑≈∆£°
--0-518570467-1188869484=:87879
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

I have used ml403 reference board recently, and now I am porting the opb_ethernet driver downloaded from the net onto the board. I use the EDK9.1 developing environment, and the driver files like "xemac.c" are copied from the EDK drivers lib. My opb_ethernet driver can work in the "No DMA mode", but the speed of FIFO is too slow to transport big files. So I transfer to "Simple DMA mode". I configured the hardware IP core in the EDK, in details, I only changed the DMA mode of opb_ethernet IP core to "Simple DMA", and then synthesize the hardware again. After that I recompile the kernel of the new xparameters.h file. But when I ping the board, in the Recv ISR function, the result of DMA operation from Recv FIFO to kernel memory is always "DMA timed out". I checked the pdf of opb_ethernet and the ipif, but I can't find any problem, especially the manner of DMA. I can only guess that there are some problems in the hardware configuration, so who can help me about that problem?
 Thank you very much.<br><p>&#32;
      <hr size=1><a href="http://mail.yahoo.com.cn/?id=89034" target=blank> 
—≈ª¢√‚∑—” œ‰£¨»´«Úµ⁄“ª” œ‰∆∑≈∆£°</a>
--0-518570467-1188869484=:87879--
