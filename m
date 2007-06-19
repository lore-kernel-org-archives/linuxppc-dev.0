Return-Path: <b.vigneshkumar@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 6604FDDF22
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jun 2007 20:36:43 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 359DA8780B8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jun 2007 03:36:32 -0700 (PDT)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 04D1A8780B5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jun 2007 03:36:32 -0700 (PDT)
Message-ID: <4677B084.5040501@gdatech.co.in>
Date: Tue, 19 Jun 2007 16:01:32 +0530
From: "b.vigneshkumar" <b.vigneshkumar@gdatech.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Regarding SCC in DTS
Content-Type: multipart/mixed; boundary="------------070905090900070305020301"
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
--------------070905090900070305020301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
This SCC Config in DTS  has some thing like  the  following.  Can You 
Explain the two lines. I would be grateful to you if you could help me 
understanding. What is that 1e and 3 doing? What does the 
interrupt-parent doing?

scc@a00 {

                .......
                interrupts = <1e 3>;
                interrupt-parent = <&Cpm_pic>;
}

Regards,
Vignesh Kumar

--------------070905090900070305020301
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


--------------070905090900070305020301--
