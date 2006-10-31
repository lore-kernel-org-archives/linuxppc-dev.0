Return-Path: <nd@bplan-gmbh.de>
Date: Tue, 31 Oct 2006 10:04:31 +0100 (MET)
Message-ID: <4547119C.3060208@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx
	Interrupt	controller	support	for	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>	
	<1162268830.25682.271.camel@localhost.localdomain>	
	<4546F68C.6070900@bplan-gmbh.de>	
	<1162279296.25682.297.camel@localhost.localdomain>	
	<45470006.1020004@bplan-gmbh.de>	
	<1162281518.25682.305.camel@localhost.localdomain>	
	<4547093E.6070502@bplan-gmbh.de>
	<1162284291.25682.323.camel@localhost.localdomain>
In-Reply-To: <1162284291.25682.323.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------020304000200040801070209"
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
--------------020304000200040801070209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
>> In my point of view, the Firmware main task is to init the HW. I do not 
>> think it's a good idea to overwrite firmware hw settings in the common 
>> code. In my mind, this should be done in platform specific area.
> 
> The setting of interrupt polarity is a matter that is at the edge
> between firmware and OS responsibility. Remember that a lot of embedded
> platforms have close to no useful firmware too.
> 

Ok. that's why I suggest to keep buggy (or none) firmware board in 
platform specific code.


> Of course, if your device-tree has bugs, then adding that feature
> afterward will suddenly break efika ...
> 

Our OpenFirmware is, of course, bugfree ;-)

Regards,

--------------020304000200040801070209
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


--------------020304000200040801070209--
