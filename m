Message-ID: <20010416185955.41462.qmail@web12402.mail.yahoo.com>
Date: Mon, 16 Apr 2001 11:59:55 -0700 (PDT)
From: Laura Dean <tralad@yahoo.com>
Subject: Mounting NFS on RPX-Lite
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everyone,

I am attempting to run embedded linux on an RPX-Lite
board. I have tried from the Hard Hat CDK and also
building from 2.4.2 source. With both, I have the same
problem - I can't mount the NFS.

The output from minicom says this:
mount: server 10.1.253.88 not responding, timed out
Root-NFS: Server returned error -5 while mounting
/tftpboot/10.1.100.111

In /var/log/messages I find this:
(...) mountd[12:10]:authenticated mount request from
10.1.100.111:800 for /tftpboot/10.1.100.111
(/tftpboot)

I expect this on the kernel I built from source, but I
was expecting the Hard Hat kernel to be mounting
/opt/hardhat/devkit/ppc/8xx/target. I assumed the
"option root-path" line in dhcpd.conf configured this.
I have copied this filesystem to 10.1.100.111 though.

I am able to mount /tftpboot from a remote Linux
system, so I think the server is configured correctly.
Here is my /etc/exports file:
/tftpboot (rw,no_root_squash)
/opt/hardhat/devkit/ppc/8xx/target
(rw,no_root_sqush,no_all_squash)

When I all a no_all_squash option to /tftpboot, I
don't get the "authenticated mount request" message in
/var/log/messages.

One other thing is that my host computer is not on a
static IP (it's on DHCP). If this would cause the
problem I can probably get a static IP, but the
sysadmins don't give them out too easily (I have one
for the board).

Does anyone have any ideas as to what could be the
problem? I will be happy to post any other information
that could help the gurus in here to identify my
problem.

Thanks,
Laura


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
