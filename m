Return-Path: <peerlessdeepaks@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186])
	by ozlabs.org (Postfix) with ESMTP id 0A955DDDFF
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 05:36:50 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so3694385rnf.16
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Dec 2008 10:36:49 -0800 (PST)
Message-ID: <cbaa36330812041036u751ea939qc0aea60002655d07@mail.gmail.com>
Date: Fri, 5 Dec 2008 00:06:48 +0530
From: "Deepak Pandian" <peerlessdeepaks@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: PCI Resource allocation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

In ppc4xx_pci i see the pci size to be declared as
 u32 lah, lal, pciah, pcial, sa;

Also at many other places I see the pci region is not capable of
handling resources > 4GB. I am planning to work on this arch specific
code to make it handle pci resource of width greater than 4 GB.

But before that i wanted to clarify whether the core kernel will be
able to handle pci regions with width greater than  4GB.

-- 
With Regards,
Deepak Pandian
"Time is precious,One day we will find that we have less than what we
think" -RandyPausch
www.peerlessdeepak.wordpress.com
