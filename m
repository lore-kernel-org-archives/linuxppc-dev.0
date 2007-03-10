Return-Path: <vancasperz@yahoo.com.cn>
Received: from web15608.mail.cnb.yahoo.com (web15608.mail.cnb.yahoo.com
	[202.165.102.62]) by ozlabs.org (Postfix) with SMTP id 65C73DDF40
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Mar 2007 16:53:13 +1100 (EST)
Date: Sat, 10 Mar 2007 13:46:31 +0800 (CST)
From: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: A problem of debugging kernel with BDI2000 and PPC
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1204505396-1173505591=:95105"
Message-ID: <754926.95105.qm@web15608.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1204505396-1173505591=:95105
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi, all
    I am trying to debug a trivial "helloworld" module with BDI2000 and PPC405EP board. The kernel in the PPC board is 2.6.15 compiled from ELDK4.0. I have tried to get a load map of the module, but there is no "-m" parameter in ELDK's insmod, and if "insmod.old -m hello_module.ko > module.map" is executed, the result is "insmod QM_MODULES : Function not implemented", while "insmod hello_module.ko" runs ok. I also have tried the "insmod" provided by busybox, but there is no content in module.map after "insmod.old -m hello_module.ko > module.map".
    So would you like to tell me it is the correct way to get the load map for module debugging? Or is there any other method to do that? Thank you very much.


Best wishes

Zhou Rui
Distributed & Embedded System Lab
School of Information Science & Engineering
Lanzhou University, P. R. China
http://dslab.lzu.edu.cn/~zr/
 		
---------------------------------
 ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ
--0-1204505396-1173505591=:95105
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi, all<br>&nbsp;&nbsp;&nbsp; I am trying to debug a trivial "helloworld" module with BDI2000 and PPC405EP board. The kernel in the PPC board is 2.6.15 compiled from ELDK4.0. I have tried to get a load map of the module, but there is no "-m" parameter in ELDK's insmod, and if "insmod.old -m hello_module.ko &gt; module.map" is executed, the result is "insmod QM_MODULES : Function not implemented", while "insmod hello_module.ko" runs ok. I also have tried the "insmod" provided by busybox, but there is no content in module.map after "insmod.old -m hello_module.ko &gt; module.map".<br>&nbsp;&nbsp;&nbsp; So would you like to tell me it is the correct way to get the load map for module debugging? Or is there any other method to do that? Thank you very much.<br><BR><BR>Best wishes<br><br>Zhou Rui<br>Distributed &amp; Embedded System Lab<br>School of Information Science &amp; Engineering<br>Lanzhou University, P. R. China<br>http://dslab.lzu.edu.cn/~zr/<p>&#32;
		<hr size=1><a href="http://cn.mail.yahoo.com/" target=blank> 
ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ</a>
--0-1204505396-1173505591=:95105--
