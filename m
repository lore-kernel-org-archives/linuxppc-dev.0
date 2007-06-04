Return-Path: <b.vigneshkumar@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 3B056DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jun 2007 20:26:40 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 577098780BB
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jun 2007 03:07:33 -0700 (PDT)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id EB6D68780B8
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jun 2007 03:07:32 -0700 (PDT)
Message-ID: <4663E35B.5010903@gdatech.co.in>
Date: Mon, 04 Jun 2007 15:33:07 +0530
From: "b.vigneshkumar" <b.vigneshkumar@gdatech.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Regarding MPC8560 porting
Content-Type: multipart/mixed; boundary="------------030504000902090207060100"
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
--------------030504000902090207060100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi
I am using 2.6.21 linux kernel for porting to MPC8560. I want to set the 
CCSRBAR value to 0xFDF0 0000.
But in the arch/powerpc/platforms/85xx/ location the mpc85xx file has 
some thing like (get_immrbase() + MPC85xx_CPM_OFFSET)

So where do I set my CCSRBAR value.

Regards,
Vignesh

--------------030504000902090207060100
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


--------------030504000902090207060100--
