Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 9D7AB67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 10:13:31 +1000 (EST)
To: Anchor <hxie@centecnetworks.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 30 Mar 2005 08:00:15 +0800."
	<4249EC0F.1010302@centecnetworks.com>
Date: Wed, 30 Mar 2005 02:12:59 +0200
Sender: wd@denx.de
Message-Id: <20050330001304.76505C108D@atlas.denx.de>
Cc: inuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: how to get a embbed linux for MPC8240 which core is 603e 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4249EC0F.1010302@centecnetworks.com> you wrote:
> 
> thank you very much! but the ELDK only support PPC8XX, PPC6XX, PPC85XX, 

This is not correct. Please see
http://www.denx.de/twiki/bin/view/DULG/ELDKSupportedTargetArchitectures
for the full list of supported target architectures.

> perhaps I need PPC6XX, I want to know, this number is cpu type identify 
> or core type Identify?

For the MPC82xx you will use the ppc_82xx packages of the ELDK, which
happens to be just a symbolic link to ppc_6xx.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never call a man a fool.  Borrow from him.
