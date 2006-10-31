Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 7606D67CB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 18:10:57 +1100 (EST)
Date: Tue, 31 Oct 2006 08:10:51 +0100 (MET)
Message-ID: <4546F6F8.1040001@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
References: <20061030174724.7155.qmail@farnsworth.org>
In-Reply-To: <20061030174724.7155.qmail@farnsworth.org>
Content-Type: multipart/mixed; boundary="------------010607080101050607020505"
Cc: linuxppc-embedded@ozlabs.org
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
--------------010607080101050607020505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dale Farnsworth wrote:
> In article <200610292310.k9TNAHXZ013852@post.webmailer.de> Nicolas wrote:
>> This patch add MPC52xx Interrupt controller for ARCH=powerpc.
>>
>> It includes the main code in arch/powerpc/sysdev/ ad well as an header file in
>> include/asm-powerpc.
>>
>> Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
> 

> I'd like to see us go the other direction, with something like the
> following (untested code).
> 

I'll include this and test.

--------------010607080101050607020505
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


--------------010607080101050607020505--
