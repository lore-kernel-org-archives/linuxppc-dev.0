Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 691E72BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Dec 2004 04:05:54 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647403@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
	"'dan@embeddededge.com'" <dan@embeddededge.com>
Date: Fri, 24 Dec 2004 12:05:36 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: seeking advise on porting custom PPC  platform (in my case it is
	variant of 8xx ) from Linux 2.4.(.26) to Linux 2.6(.10-rc3)
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

In Linux 2.6 I see the new directory arch/ppc/syslib, which does not exist
in Linux 2.4(.26).
I would GREATLY APPRECIATE if Tom or Dan (or someone else) could explain
what are the reasons for creating this new directory and describe on what
basis existing
Linux 2.4 files went there and why  ... 
and if there any new files (vs Linux 2.4) were created in that new directory
?  

In general, I am seeking advise on porting PPC platform
(in my case it isvariant of 8xx ) from Linux 2.4.(.26) to Linux
2.6(.10-rc3).
 Did anyone created howto document on this subject ?

Thanks,

Alex
