Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 2C3CDDDFB0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 03:12:53 +1100 (EST)
Received: from localhost (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id C572943400C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 17:10:17 +0100 (CET)
Received: from nausicaa2.coritel.it ([127.0.0.1])
	by localhost (nausicaa2.coritel.it [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id OxVMuNhaHxZq for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 17:10:17 +0100 (CET)
Received: from [192.168.2.2] (217-133-82-13.b2b.tiscali.it [217.133.82.13])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 67029434001
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 17:10:16 +0100 (CET)
Message-ID: <47BC51B5.50204@coritel.it>
Date: Wed, 20 Feb 2008 17:13:41 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8641D PCI-Express error
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> Marco Stornelli wrote:
>>
>>> No, but I can try to backport the PCI-E code from 2.6.24 to 2.6.18
>>> if it could help. What do you think about it? Do you think this
>>> problem could be not present in 2.6.24?
>>> I have no idea there, honestly.  Sorry.

>As Jon said, try 2.6.24 and see if it has an issue, if so we can look
>at helping.  if not, you know you need to back port the fixes.

>- k

I've "backported" the PCI-Express code from 2.6.24 to 2.6.18, but it
still doesn't work, I have the same problem (sigh), could you give me
any suggestions?

Thanks.

Marco
