From: Jeff Kowing <jeffrey.d.kowing@nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15829.8892.699280.307557@igor.jsc.nasa.gov>
Date: Fri, 15 Nov 2002 10:37:16 -0600
To: linuxppc-embedded@lists.linuxppc.org
Subject: NFS root manipulation without being superuser?
Reply-To: jeffrey.d.kowing@nasa.gov
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


During embedded system developement, I use an NFS root mounted
filesystem that is exported from my development workstation.  I am
constantly having to "su root" on my development workstation when I
want to manipulate the root filesystem for the target machine. I was
wondering if anyone uses a safer technique that allows manipulation of
the target's root filesystem without being root on the development
workstation.

I know I could make the exported filesystem all be owned by my
unprivledged user and group name, but I would like the target machine
to see those files as owned by root as would normally be the case.

Anyways, I was just curious if I am missing out on some cool technique
that other's use that I am not brilliant enough to come up with on my
own.

Thanks.
--
Jeff Kowing
jeffrey.d.kowing@nasa.gov

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
