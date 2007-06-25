Return-Path: <greg.crocker@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by ozlabs.org (Postfix) with ESMTP id 5C19DDDEEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 05:42:11 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id t13so1383498wxc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jun 2007 12:42:09 -0700 (PDT)
Message-ID: <e4fee3c50706251242h722c00dbpfc7881aa890a5e1e@mail.gmail.com>
Date: Mon, 25 Jun 2007 15:42:09 -0400
From: "Greg Crocker" <greg.crocker@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: ML403 gigabit ethernet bandwidth - 2.6 kernel
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_40291_15729050.1182800529356"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_40291_15729050.1182800529356
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I was able to achieve ~320 Mbit/sec data rate using the Gigabit System
Reference Design (GSRD XAPP535/536) from Xilinx.  This utilizes the
LocalLink TEMAC to perform the transfers.  The reference design provides the
Linux 2.4 drivers that can be ported to Linux 2.6 with a little effort.

This implementation did not use checksum offloading and the data rates were
achieved using TCP_STREAM on netperf.

Greg

------=_Part_40291_15729050.1182800529356
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I was able to achieve ~320 Mbit/sec data rate using the Gigabit System Reference Design (GSRD XAPP535/536) from Xilinx.&nbsp; This utilizes the LocalLink TEMAC to perform the transfers.&nbsp; The reference design provides the Linux 
2.4 drivers that can be ported to Linux 2.6 with a little effort.&nbsp; <br><br>This implementation did not use checksum offloading and the data rates were achieved using TCP_STREAM on netperf.<br><br>Greg<br>

------=_Part_40291_15729050.1182800529356--
