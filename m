Return-Path: <arunkat@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 02C4167A45
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Jun 2006 18:52:30 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id a27so226660nfc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Jun 2006 01:52:29 -0700 (PDT)
Message-ID: <edd12c050606220146i57282781o2052679c8f6108ef@mail.gmail.com>
Date: Thu, 22 Jun 2006 14:16:10 +0530
From: "Arun Kumar" <arunkat@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: entry point of kernel in RAM at 0x0c--linux tree file name
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2866_21053124.1150965970312"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2866_21053124.1150965970312
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,
I would like to kow what is the entry point to kernel at 0x000 after
decompressing and passing control to 0x0c .
My kernel crashes somewhere after uncomressing and jumping to 0x0c .

If any one can help the .c /.S file that contains the source of kernel
startup code in RAM at 0x0/0x0c .

thanks,
Arun

------=_Part_2866_21053124.1150965970312
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,<br>I would like to kow what is the entry point to kernel at 0x000 after decompressing and passing control to 0x0c .<br>My kernel crashes somewhere after uncomressing and jumping to 0x0c .<br><br>If any one can help the .c /.S file that contains the source of kernel startup code in RAM at 0x0/0x0c .
<br><br>thanks,<br>Arun<br>

------=_Part_2866_21053124.1150965970312--
