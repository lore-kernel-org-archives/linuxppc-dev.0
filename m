From: "Chris Hallinan" <clh@net1plus.com>
To: "Coenraad Jacobsz" <cjj@research.canon.com.au>,
        <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: DHCP client
Date: Mon, 21 Aug 2000 10:07:28 -0400
Message-ID: <NEBBKJPFOLJNBMFNKBIIAEKKCCAA.clh@net1plus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <39A0ED3D.BDCDEA7F@research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We tried the ISC implementation (version 2.0) of the client.
It compiled and executed successfully on our '850 board (BSE
IP) with very little effort. We are using the Monta Vista
CDK 1.0 development environment.

The bulk of the effort was involved with providing
persistent storage of the lease data required by DHCP in our
flash.

The client seems to work well...I also use it on my laptop,
and I've used it at several customer sites to configure my
laptop for their network without any problems.

-Chris Hallinan
DS4.COM, Inc.

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
Of Coenraad Jacobsz
Sent: Monday, August 21, 2000 4:50 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: DHCP client


Hi everyone

Is there anyone who has implemented a DHCP client for 8xx
successfully?
If so, could you point us in the right direction please.

A search for DHCP on the MontaVista site came up with "No
documents
match...", but there are other sources e.g. the www.isc.org
site, or
maybe Red Hat's 'pump'  However, that may require
substantial
modification...

Any help appreciated

Thanks,
Coenraad


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
