Return-Path: <vantranbk@yahoo.com.au>
Received: from web33003.mail.mud.yahoo.com (web33003.mail.mud.yahoo.com
	[209.191.69.118]) by ozlabs.org (Postfix) with SMTP id 5B39067B6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 22:46:52 +1000 (EST)
Message-ID: <20061020124651.41291.qmail@web33003.mail.mud.yahoo.com>
Date: Fri, 20 Oct 2006 22:46:51 +1000 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: Build openssl in ELDK 3.1.1
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1409984804-1161348411=:41008"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1409984804-1161348411=:41008
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Wolfgang Denk
I'm reinstall ELDK 3.1.1 and it ok
I rebuild openssl like that
- Download openssl-0.9.7f-7.10_1.src.rpm in <project>/usr/src/denx/SRPMS
- Go to <project>/usr/src/denx/SRPMS and run
        ppc_8xx-rpm -iv openssl-0.9.7f-7.10_1.src.rpm
- Go to <project>/usr/src/denx/SPECS and run
       ppc_8xx-rpmbuild  openssl.spec
Then  I receive  in  <project>/usr/src/denx/openssl-0.9.7f/   libssl.so.0.9.7 and  openssl in <project>/usr/src/denx/openssl-0.9.7f/apps

That's OK
But I don't know Was command openssl added in image in <project>/ppc_8xx/images? If no how i can do it ?
I also want to rebuild kernel but i only receive vmlinux in <project>/ppc_8xx/usr/src/linux/ Was vmlinux added in image in <project>/ppc_8xx/images? If no how i can do it ?
If I want to build an application but not in ftp://ftp.sunet.se/pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/sources/target/SRPMS/
 how can I do?

Thanks
LeVan

 		
---------------------------------
On Yahoo!7
  Fuel Price Watch: Find the cheapest petrol in your area
--0-1409984804-1161348411=:41008
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Wolfgang Denk<br>I'm reinstall ELDK 3.1.1 and it ok<br>I rebuild openssl like that<br>- Download openssl-0.9.7f-7.10_1.src.rpm in &lt;project&gt;/usr/src/denx/SRPMS<br>- Go to &lt;project&gt;/usr/src/denx/SRPMS and run<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc_8xx-rpm -iv openssl-0.9.7f-7.10_1.src.rpm<br>- Go to &lt;project&gt;/usr/src/denx/SPECS and run<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc_8xx-rpmbuild&nbsp; openssl.spec<br>Then&nbsp; I receive&nbsp; in&nbsp; &lt;project&gt;/usr/src/denx/openssl-0.9.7f/&nbsp;&nbsp; libssl.so.0.9.7 and&nbsp; openssl in &lt;project&gt;/usr/src/denx/openssl-0.9.7f/apps<br><br>That's OK<br>But I don't know Was command openssl added in image in &lt;project&gt;/ppc_8xx/images? If no how i can do it ?<br>I also want to rebuild kernel but i only receive vmlinux in &lt;project&gt;/ppc_8xx/usr/src/linux/ Was vmlinux added in image in &lt;project&gt;/ppc_8xx/images? If no how i can do it ?<br>If I want to build an application
 but not in ftp://ftp.sunet.se/pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/sources/target/SRPMS/<br>&nbsp;how can I do?<br><br>Thanks<br>LeVan<br><p>&#32;
		<hr size=1>On Yahoo!7<br> 
<a 
href="http://au.rd.yahoo.com/mail/tag/fuelpricewatch/**http%3A%2F%2Fau.maps.yahoo.com%2Ffuelwatch%2F"> 
Fuel Price Watch: Find the cheapest petrol in your area</a>
--0-1409984804-1161348411=:41008--
