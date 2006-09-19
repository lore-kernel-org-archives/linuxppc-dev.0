Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id F0A5567B64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 20:13:25 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GPcbS-00032X-QM
	for linuxppc-embedded@ozlabs.org; Tue, 19 Sep 2006 12:13:22 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
References: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA645@XSJ-EXCHVS1.xlnx.xilinx.com>
Date: Tue, 19 Sep 2006 12:13:22 +0200
In-Reply-To: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA645@XSJ-EXCHVS1.xlnx.xilinx.com>
	(John Bonesio's message of "Thu, 14 Sep 2006 18:40:53 +0200")
Message-ID: <87d59syxj1.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "JB" == John Bonesio <john.bonesio@xilinx.com> writes:

Hi,

JB> << The Xilinx approach of overwriting the source tree just feels
JB> wrong, and no one seems to want to do it that way.>>

JB> I am in the group that has control over how this is done. What
JB> would you propose be done different? Keep in mind that we are
JB> trying to support a process where someone builds a hardware design
JB> and the later changes it with new peripherals or perhaps makes
JB> minor tweaks. We want to make the updating of the Linux kernel to
JB> reflect these hardware changes easy for people.

Don't patch the kernel sources from EDK, but instead get the drivers
integrated in the mainline kernel. Either do config options for the
various IP versions or use runtime detection.

We're doing Linux development for several platforms and using a single
kernel tree for it all is absolute critical to my sanity..

The EDK drivers are nice as examples of how to use the IP cores, but
the defined and documented interface should be the IP, not the EDK
drivers.

-- 
Bye, Peter Korsgaard
