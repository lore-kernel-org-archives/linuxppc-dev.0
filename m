Return-Path: <meador_inge@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CDF1EB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Feb 2011 05:00:34 +1100 (EST)
Message-ID: <4D5C10B9.9010702@mentor.com>
Date: Wed, 16 Feb 2011 12:00:25 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org
Subject: Using CONFIG_PHYSICAL_START
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

Quick question about the support for booting at a non-zero base address 
(as committed here: 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=37dd2badcfcec35f5e21a0926968d77a404f03c3). 
  Is booting from a non-zero address as simple as changing 
"CONFIG_PHYSICAL_START" (assuming it meets the alignment constraints, of 
course)?

For example, I want to boot from a non-zero address on the P1022DS.  I 
should just be able to change "CONFIG_PHYSICAL_START" to, say, 
0x08000000, and it should work, right?  Any other bits that need to be 
done (i.e. U-Boot or device tree magic)?

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
