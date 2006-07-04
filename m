Return-Path: <hubert.loewenguth@thales-bm.com>
Received: from thsmsgxrt11p.thalesgroup.com (thsmsgxrt11p.thalesgroup.com
	[192.54.144.134]) by ozlabs.org (Postfix) with ESMTP id E1B4E67B32
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 18:12:23 +1000 (EST)
Received: from thsmsgirt22p.corp.thales (unknown [10.33.231.6])
	by thsmsgxrt11p.thalesgroup.com (Postfix) with ESMTP id 7A97E3C10B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 10:12:20 +0200 (CEST)
Received: from thsmsgiav13p.corp.thales (10.33.231.33) by
	thsmsgirt22p.corp.thales (7.2.055.4)
	id 44447C9500EDE14A for linuxppc-embedded@ozlabs.org;
	Tue, 4 Jul 2006 10:12:17 +0200
Received: from cnfplex.tbm.fr.thales (unknown [10.33.13.187])
	by thsmsgirt12p.corp.thales (Postfix) with ESMTP id 634393C01F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 10:12:20 +0200 (CEST)
Received: from [178.1.60.47] (178.1.60.47) by cnfplex.tbm.fr.thales (NPlex
	6.5.026) id 44A4B6F0000036BF for linuxppc-embedded@ozlabs.org;
	Tue, 4 Jul 2006 10:12:20 +0200
Message-ID: <44AA22E3.3050701@thales-bm.com>
Date: Tue, 04 Jul 2006 10:12:19 +0200
From: "hubert.loewenguth" <hubert.loewenguth@thales-bm.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: what is the MPC8260 spi maximum rate ?
Content-Type: multipart/mixed; boundary="------------030502000908070107010207"
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
--------------030502000908070107010207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody

I have a question about the spi on the MPC8260.
I have written a driver for this controller but there is something in 
the MPC8260 documentation I don't understand:

It is written in MPC8260 documentation (SPI chapter) : " The maximum 
sustained data rate that the SPI supports is SYSTEMCLK/50. However the 
spi can transfer a single character at much higher rates (SYSTEMCLK/4 in 
master mode)".

My really stupid question is ...... what is "SYSTEMCLK" ???????
is it the BRG_CLK ? the CPM_CLK or the CPU_CLK ????

Seeing that in the SPMODE register, the maximum SPI CLK possible is 
BRG_CLK/4, I imagine that this "SYSTEMCLK" is BRG_CLK, but this looks 
very strange .....


This question is quite stupid but very important for me in order to know 
if that controller permit to exchange data with one of our extention 
board at 1.2 MHz.

Anybody knows ?
Thanks very much for any help .

--------------030502000908070107010207
Content-Type: text/x-vcard; charset=utf-8;
 name="hubert.loewenguth.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hubert.loewenguth.vcf"

begin:vcard
fn:Hubert Loewenguth
n:Loewenguth;Hubert
org:Thales Broadcast & Multimedia
adr:;;1 rue de l'hautil;Conflans Ste Honorine;;78700;France
email;internet:hubert.loewenguth@thales-bm.com
title:Software Engineer
tel;work:01-34-90-37-56
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------030502000908070107010207--
