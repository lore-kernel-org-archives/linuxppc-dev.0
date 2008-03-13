Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 09C51DDFF0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Mar 2008 02:52:53 +1100 (EST)
Message-ID: <405422271.18508@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: support.asia@freescale.com, linuxppc-embedded@ozlabs.org,
	u-boot-users@lists.sourceforge.net
Date: Thu, 13 Mar 2008 23:31:11 +0800
Subject: Hi,friends, the question about the u-boot and device tree?
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,friends,

I make all the frequency(timebase-frequency;bus-frequency;clock-frequency) value
on device tree file equal to zero, I think those frequency will filled by u-boot
during bootm, but in fact, the u-boot did not fill any frequency. after bootm,
crashed. Why?

Why so many document point out that the zero value will be filled by u-boot?
