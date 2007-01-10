Return-Path: <tlopez@aotek.es>
Message-ID: <45A4BC58.5010700@aotek.es>
Date: Wed, 10 Jan 2007 11:13:44 +0100
From: Txema Lopez <tlopez@aotek.es>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: MPC5200B TxRTS auto-toggle mode.
Content-Type: multipart/mixed;
	boundary=------------080005030003010605080903
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
--------------080005030003010605080903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm working in a MPC5200B based plataform. I want to use the TXRTS 
feature of the MPC5200B's PSC-UART(auto toggle when the transmitter 
ends) to manage a rs485 transceiver but I'm unable to do it. Googling, 
I've found that a year ago Stefan Eletzhofer asked for the same 
question, but I can't find any answer to this question (neither in the 
linuxppc-embedded mailing list archives). Did anyone find a solution? Is 
there a patch available for a Denx's 2.4.25 kernel?.

Best regards,

--------------080005030003010605080903
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


--------------080005030003010605080903--
