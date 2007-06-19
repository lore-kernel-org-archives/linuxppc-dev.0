Return-Path: <b.vigneshkumar@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id BEA44DDF8A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jun 2007 22:24:15 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 512648780B4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jun 2007 05:24:14 -0700 (PDT)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 12DA88780AB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jun 2007 05:24:14 -0700 (PDT)
Message-ID: <4677C9C2.6080802@gdatech.co.in>
Date: Tue, 19 Jun 2007 17:49:14 +0530
From: "b.vigneshkumar" <b.vigneshkumar@gdatech.co.in>
MIME-Version: 1.0
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Regarding SCC in DTS File
Content-Type: multipart/mixed; boundary="------------040503060800080004080408"
Reply-To: b.vigneshkumar@gdatech.co.in
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
--------------040503060800080004080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

What does these two lines in DTS File.
Can u let me know what this suppose to mean

scc@a00 {
		........
		rx-clock = <1>;
		tx-clock = <1>;
                ........
  		interrupts = <1e 3>;
                interrupt-parent = <&Cpm_pic>;
 }



Actually where can we get a better documentation for the DTS File? If 
you have any reference please let me know. Thanks A Lot.

Regards,
Vignesh

--------------040503060800080004080408
Content-Type: text/x-vcard; charset=utf-8;
 name="b.vigneshkumar.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="b.vigneshkumar.vcf"

begin:vcard
fn:Vignesh  Kumar  Bagavathsingh
n:Bagavathsingh;Vignesh  Kumar 
email;internet:b.vigneshkumar@gdatech.com
tel;work:6513
tel;home:044-23773210
version:2.1
end:vcard


--------------040503060800080004080408--
