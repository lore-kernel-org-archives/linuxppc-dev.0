Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04f.nortel.com (zcars04f.nortel.com [47.129.242.57])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8053BDDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 08:49:49 +1100 (EST)
Message-ID: <490A2BF0.7080303@nortel.com>
Date: Thu, 30 Oct 2008 15:49:36 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: mgreer@mvista.com, linuxppc-dev@ozlabs.org
Subject: trying to boot 2.6.27 on PrPMC280
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to boot 2.6.27 on a Moto PrPMC280.  Currently it just hangs 
after "Passing control to the loaded file/image.".

With an earlier kernel (2.6.14) I use a zImage.pplus file and netboot 
with the "-z" option telling it to use PReP mode.  With new kernels I 
assume I use the dtbImage.prpmc2800 file, but what's the proper 
incantation for netboot?

Thanks,

Chris
