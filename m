Return-Path: <flucifredi@acm.org>
Received: from mail3.speakeasy.net (mail3.speakeasy.net [216.254.0.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48B4B2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jan 2005 08:04:56 +1100 (EST)
Received: from blhealthcare.com (HELO [192.168.1.201])
	(blsoftware@[151.204.230.210]) (envelope-sender <flucifredi@acm.org>)
	by mail3.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
	for <linuxppc-embedded@ozlabs.org>; 6 Jan 2005 20:58:14 -0000
Message-ID: <41DDA5DA.1030802@acm.org>
Date: Thu, 06 Jan 2005 15:55:54 -0500
From: Federico Lucifredi <flucifredi@acm.org>
MIME-Version: 1.0
To: "Linux-ppc [mailing list]" <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: MPC8272ADS and frame buffer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Federico,
    It turns out you can solve your problem by using the Epson SD13806 
evaluation board (s5u13806b00c). It comes with drivers distributed, 
inanely enough, as a patch for a specific kernel, so prepare for some 
hand-patching. Other than that, it works.

    Love answering myself :)  -Federico

>Hello Linux-PPCers,
>    I have a quick one: I am looking at the Arabella kernel on the 
>MPC8272ADS, which I am planning to use as a prototyping platform while 
>we get to figure out a BSP for our custom board.
>
>    Now, I have an Epson card on hand (13806) which I know to be working 
>on ppc, and which has drivers as a kernel patch for 2.4.21, and I have a 
>radeon card on hand which I used to like because of its vesa 2.0 
>compliance.  The first brings up the problem of porting the patch to the 
>2.4.26 kernel, which Arabella/Yuli Barcohen customized to the 
>MPC8272ADS. The latter, according to Yuli himself, won't work because of 
>BIOS initialization issues.
>
>    I do not mind buying another card if necessary (time is at a greater 
>premium), but I would like to know that there is a 2.4.6 driver for it 
>or that it is supported by Arabella's kernel.
>
>Anyone here using the Arabella BSP on the 8272ADS with a frame buffer on 
>it ? What setup are you using?
>
>-Federico
>  
>

-- 
_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish

Muad'Dib of Caladan (Federico L. Lucifredi)- Harvard University & BU
http://metcs.bu.edu/~lucifred
