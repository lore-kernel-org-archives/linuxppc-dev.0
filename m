Return-Path: <carlos.mitidieri@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id D3B80679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 17:32:03 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 244E7FB876
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 08:32:00 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 0DA4BFB876
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 08:32:00 +0200 (CEST)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id AF27FD002F6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 08:31:59 +0200 (CEST)
From: Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: pci-x
Date: Fri, 31 Mar 2006 08:52:28 +0200
References: <200603231435.01008.carlos.mitidieri@sysgo.com>
	<200603281651.53196.carlos.mitidieri@sysgo.com>
	<621AE6AC-D37E-4EB5-9390-7050B654C692@freescale.com>
In-Reply-To: <621AE6AC-D37E-4EB5-9390-7050B654C692@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603310852.29987.carlos.mitidieri@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am using  a Rev PILOT board, S/N:0251
To my discernment, a Rev PILOT is lower than a Rev A. 
Is that correct?  
   
By the way, thank you very much.

> Are you using a Rev A or higher board?  PCI-X doesn't work on earlier
> systems.
>
> Also, make sure your board is configured to run PCI at 66 MHz.  PCI-X
> doesn't work at 33 MHz.
>
>
> Andy Fleming

Best regards,
-- 
Carlos Mitidieri
SYSGO AG - Office Ulm
