Return-Path: <Marc.Howard@KLA-Tencor.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 24 Feb 2005 18:42:40 -0800
Message-ID: <91B22F93A880FA48879475E134D6F0BE8E7CB9@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: <Linuxppc-embedded@ozlabs.org>
Subject: Gigibit ethernet ports on Ocotea + 2.6.10
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

Are there any patches to 2.6.10 that are needed to make the gigabit
ethernet ports (eth2 and eth3) work on Ocotea?  I can boot on eth2 using
U-Boot and get to the point where linux is (supposedly) making a BOOTP
request (although there is no traffic present on that interface).
According to my archive searching the fixes should already be in there.
Is there a pending patch repository somewhere?

As a side question are there any kernel command line options that would
force eth2 to a fixed IP address?  I'm currently using:

console=3DttyS0,115200 root=3D/dev/nfs rw
nfsroot=3D192.168.168.108:/projects/targets/ppc_4xx
ip=3D192.168.168.111:192.168.168.108:192.168.168.108:255.255.255.0:ppc440=
:
:off

...but this of course doesn't associate eth2 with the desired IP address
(192.168.168.111)

Thanks,

Marc W. Howard
