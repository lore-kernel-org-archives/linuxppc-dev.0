From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <D96E2AFA0DF3D211B139009027454948034CBE5D@helios.gnv.tcc.thomson-csf.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Driver on Linux
Date: Fri, 27 Jun 2003 19:10:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I am working on a PPC860.

I have developped two drivers.

The driver 2 needs to use functions that are in driver 1.
driver 1 is /dev/visu.

I thought I could make fd=open("/dev/visu", 0) in init of the driver 2 but I
get ooops.
I also need to make something like ioctl(fd, IO_Special... )but the function
ioctl is unknown in the kernel.

What is the right way to work when you need to do that ?

Thanks.

Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
