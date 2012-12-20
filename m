Return-Path: <R.Patil@mei-india.com>
Received: from antispam.messung.com (outbond.messung.com [210.212.173.45])
 by ozlabs.org (Postfix) with ESMTP id 1291A2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2012 19:39:02 +1100 (EST)
In-Reply-To: 
Subject: Adding 'of_platform' bus support to the platform driver
From: R.Patil@mei-india.com
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <OFC91E62B9.4D486BD1-ON65257ADA.002E22B1-65257ADA.002E22B7@LocalDomain>
Date: Thu, 20 Dec 2012 13:53:55 +0530
Content-Type: text/plain;
	charset=ISO-8859-1
MIME-Version: 1.0
References: 
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

We are working on one of the platform drivers for our board (based on MPC83=
13ERDB). Previously, this driver was supporting platform bus but now we wan=
t to change it to support 'of=5Fplatform' bus. While supporting platform bu=
s, the platform device structure is initialised in board setup file, and pl=
atform device is registered using 'platform=5Fdevice=5Fregister=5Fsimple' c=
all.=20

Now if we want to support 'of=5Fplatform' bus, the information related to t=
he the device will be extracted from device tree in the platform driver its=
elf and we would not be required to call 'platform=5Fdevice=5Fregister=5Fsi=
mple' to register the platform device. Is this understanding correct?

Thanks and Regards,
RahulEmail Disclaimer:
  ---------------------------

This e-mail and any files transmitted with it are for the sole use of the i=
ntended recipient(s) and may contain confidential and  privileged informati=
on. Computer viruses can be transmitted via email.The recipient should chec=
k this email and any  attachments for the presence of viruses. The company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.
