Return-Path: <ramkumarj2000@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186])
	by ozlabs.org (Postfix) with ESMTP id 38BFFDDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 02:15:21 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id v46so2049123rnb.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 08:15:19 -0700 (PDT)
Message-ID: <4f8c3030803120815o7dcf5e8xb74650c8b993d26d@mail.gmail.com>
Date: Wed, 12 Mar 2008 23:15:16 +0800
From: "Ramkumar J" <ramkumarj2000@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: XMD to debug Linux kernel 2.6
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_68_22652601.1205334917027"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_68_22652601.1205334917027
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,
I need to dump the TLB entries, i-cache and d-cache entries on a ML-403
board ( I use a PowerPc based design) using the Xilinx Parallel-4 Cable.
When I download the zImage.elf using dow command on XMD, I m not able to
access the TLB and cache address special memory mappings as displayed by the
XMD. I suspect that XMD only allows the dump for sections inside the elf
file. If its true, then how to access the sections of kernel.
Could XMD be used to debug a linux kernel by dumping the registers, TLBs,
cache entries,etc. Am I missing anything. Any pointers would be very
helpful.

Thanks and Regards,
Ramkumar

------=_Part_68_22652601.1205334917027
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<p>Hi All,</p>
<div>I need to dump the TLB entries, i-cache and d-cache entries on a ML-403 board ( I use a PowerPc based design) using the Xilinx Parallel-4 Cable. When I&nbsp;download the zImage.elf using dow command on XMD, I m not able to access the TLB and cache address special memory mappings as displayed by the XMD. I suspect that XMD only allows the dump for sections inside the elf file. If its true, then how to access the sections of kernel.</div>

<div>Could XMD be used to debug a linux kernel by dumping the registers, TLBs, cache entries,etc. Am I missing anything. Any pointers would be very helpful.</div>
<p>Thanks and Regards,<br>Ramkumar</p>

------=_Part_68_22652601.1205334917027--
