Return-Path: <carlos.mitidieri@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id E467A67A60
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Mar 2006 02:07:37 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 4F395FB865
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 16:07:34 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 35258FB865
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 16:07:34 +0100 (CET)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id 124CA20B7C7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 16:07:33 +0100 (CET)
From: Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: pci-x
Date: Fri, 24 Mar 2006 16:07:35 +0100
References: <200603231435.01008.carlos.mitidieri@sysgo.com>
	<200603241221.44576.carlos.mitidieri@sysgo.com>
	<24661B8C-C4DF-4D9C-8F4A-F2E6600AFFE2@kernel.crashing.org>
In-Reply-To: <24661B8C-C4DF-4D9C-8F4A-F2E6600AFFE2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603241607.35267.carlos.mitidieri@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 24 March 2006 15:53, Kumar Gala wrote:
> That seems like a driver problem.  Does lspci show your devices after
> you boot?  Also, what kernel ver are you using?

No, the device behind the bridge is not recognized, although the bridge itself 
is. I am using kernel 2.6.15.

-- 
Carlos Mitidieri
SYSGO AG - Office Ulm
