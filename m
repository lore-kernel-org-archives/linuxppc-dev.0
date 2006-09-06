Return-Path: <tlopez@aotek.es>
Received: from sollube.sarenet.es (mx1.sarenet.es [194.30.0.37])
	by ozlabs.org (Postfix) with ESMTP id 8149567B82
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 17:48:36 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by sollube.sarenet.es (Postfix) with ESMTP id 80A91374BD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 09:30:15 +0200 (CEST)
Message-ID: <44FE7907.2090209@aotek.es>
Date: Wed, 06 Sep 2006 09:30:15 +0200
From: Txema Lopez <tlopez@aotek.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC5200 SPI interface.
Content-Type: multipart/mixed;
	boundary=------------030607010907020204020809
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030607010907020204020809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,
We are developping a Lite5200B based custom board and we are planning to 
connect some SPI peripherals. But we are not sure about what MPC5200 SPI 
interface choose.  Does anyone know what are the 
advantages/disadvantages of use the MPC5200 SPI dedicated interface or  
an PSC (PSC3) as the SPI interface?. The linux kernel includes both 
interfaces but we can not see in the documentation anything about this 
aspect. Any kind of information will be welcomed.

Best Regards,
José María López.

--------------030607010907020204020809
Content-Type: text/x-vcard; charset=utf-8;
 name="tlopez.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tlopez.vcf"

begin:vcard
fn:Jose Maria Lopez
n:Lopez;Jose Maria
org:Fagor Automation S. Coop.
adr:;;San Andres 19. Apdo. 144;Arrasate-Mondragon;;20500;Spain
email;internet:tlopez@aotek.es
title:Sotware engineer
tel;work:(34) 943719200
tel;fax:(34) 943791712 
x-mozilla-html:FALSE
url:http://www.fagorautomation.es
version:2.1
end:vcard


--------------030607010907020204020809--
