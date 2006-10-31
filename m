Return-Path: <nd@bplan-gmbh.de>
Date: Tue, 31 Oct 2006 09:28:49 +0100 (MET)
Message-ID: <4547093E.6070502@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt
	controller	support	for	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>	
	<1162268830.25682.271.camel@localhost.localdomain>	
	<4546F68C.6070900@bplan-gmbh.de>	
	<1162279296.25682.297.camel@localhost.localdomain>	
	<45470006.1020004@bplan-gmbh.de>
	<1162281518.25682.305.camel@localhost.localdomain>
In-Reply-To: <1162281518.25682.305.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------030801040603020803090208"
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030801040603020803090208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Tue, 2006-10-31 at 08:49 +0100, Nicolas DET wrote:
> 
>> In this case: shouldn't the platform init correctly setup the hw instead 
>> of the Firmware?
> 
> No. The device-tree contains the polarity information, it gets passed to
> the PIC driver via set_irq_type() anyway so there is no need in theory
> to have the HW initialized by the firmware if that is implemented. In
> the case where it's not, however, you indeed need to make sure the
> firmware have programmed the same settings in the HW as are exposed in
> the device-tree.
> 

In my point of view, the Firmware main task is to init the HW. I do not 
think it's a good idea to overwrite firmware hw settings in the common 
code. In my mind, this should be done in platform specific area.

Regards,

--------------030801040603020803090208
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------030801040603020803090208--
