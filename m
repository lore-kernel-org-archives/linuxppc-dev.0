Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27EB8B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 15:47:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: FW: Ethernet driver WR linux
Date: Tue, 9 Aug 2011 11:16:54 +0530
Message-ID: <07ACDFB8ECA8EF47863A613BC01BBB220344EACF@HYD-MKD-MBX02.wipro.com>
In-Reply-To: <4E404D1F.6020503@freescale.com>
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank Scott. I am working on a legacy project Which is using 2.6.21
linux kernel so the device tree is based on that.
Can you let me why the probe error of the driver happens. So that I can
keep a patch in the code.Or What exacly in the device tree it is
missing. That would be of great help.

Thanks & Regards,
Smitha

-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com] 
Sent: Tuesday, August 09, 2011 2:25 AM
To: Smitha Vanga (WT01 - GMT-Telecom Equipment)
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: FW: Ethernet driver WR linux

On 08/08/2011 12:53 AM, smitha.vanga@wipro.com wrote:
>  
> Hi Scott,
> 
> Below is the .dts file. My board is based on mpc8247. Currently using 
> FCC1.

This device tree is based on something very short-lived when 82xx
support was first being worked on for 82xx, around 2.6.24 or so.  Please
redo it from scratch based on what is in the current kernel.

-Scott


Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com
