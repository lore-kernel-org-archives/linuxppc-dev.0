Message-Id: <200211190608.AAA15597@lists.linuxppc.org>
Date: Tue, 19 Nov 2002 14:14:55 +0800
From: "Li Xiangrong" <lixiangrong@china.com>
To: "mlocke@mvista.com" <mlocke@mvista.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: pcmcia problem
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, mlocke,
    I am now porting the hhl to a custom board with pcmcia. However, I have trouble dealing with pcmcia and i write the mail for ur help.
	I configed the kernel with pcmcia module and then I compiled the kernel. I ported the kernel on my board and inserted the pcmcia card(a intel series 2+ flash card). Having started the cardmgr, i checked the stab of socket and got information that 'anonymous memory'.I checked the schematics of Powerpc 860 and pcmcia socket carefully and confirmed that the hardware platform is ok. Surely the problem happens on the drivers(or illegal kernel configuration).
	I checked in the maillist of ppclinux-embedded and got tips there. People discussed the same issue before. From the maillist, I got that:
		1. hhl should be patched: there's 2 hhl patch for pcmcia:'hhl-8xx_pcmcia-3.1.19.patch'and 'hhl-8xx-kernel_pcmcia.patch' .
		2. a conf file should be changed.'/etc/sysconfig/pcmcia' should be changed the i82365 to m8xx_pcmica.
	 I then checked the target system but found no sysconfig under the directory of /etc. And I can not find the patches on my hhl disk or on the monta vista zone. My question is :
	1. Are these two patches indispensable? Since I have configed the kernel with pcmcia support, must I re-install these 2 patches?
	2. How can I get these 2 patches? I have checked the disk and the hhl zone with no results. Where r they?
	Any suggestion is appreciated.


Best regards.

Li Xiangrong
lixiangrong@china.com
2002-11-19

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
