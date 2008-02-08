Return-Path: <rs@carriercomm.com>
Received: from ccomm-ex1.ccomm.com (unknown [207.158.3.3])
	by ozlabs.org (Postfix) with ESMTP id 681A5DDF32
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Feb 2008 05:39:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Virtex 4 PPC] Problem mountin rootfs via NFS
Date: Fri, 8 Feb 2008 10:27:51 -0800
Message-ID: <EE63F03D9E04774997AEBCD21FC77F25190363@ccomm-ex1.ccomm.com>
From: "Sugathan, Rupesh" <rs@carriercomm.com>
To: "IngoM" <ingo.maindorfer@ipm.fraunhofer.de>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


in the meantime, I get up my toolchain and an linux-kernel from xilinx
git-repository.
Hardware is an FX12 Mini-Module form AVNET, standard design with
LL-TEMAC, EDK 9.2.
Kernel boots fine till he try to mount his rootfs via NFS. NFS is
working correctly, probed with some other maschines. Some times kernel
can mount NFS, somtimes kernel panics trying this.
I already try some additional parameters found here on the list like
"tcp,no_lock" but didn't help. Also probed direct connection, connection
via a 100 MBit switch. No success.
Another thing I tried is set ip=3Ddhcp, the device find our DHCP-Server
and gets an address. So I think network should ok, but where comes the
NFS trouble from?

=20
Do you have a 'console' device file set up in your NFS rootfilesystem?=20

Thanks
--
Rupesh Sugathan
