Message-ID: <41EDEC3C1B88D51186EB00A0C9CFADF702FA50@AMWMAIL>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'Jim Duey'" <jduey@ccc-dcs.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Logging into embedded 8xx device from Windows with Samba
Date: Fri, 17 Aug 2001 15:32:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have "almost" successfully gotten samba running on my embedded MPC823
device. I am running samba 2.2.1a. I had to cross compile it on my x86 host
for the powerpc. I have the embedded device setup as the samba server and am
able to see it in Network Neighborhood on my Windows PC. However, when I
attempt to login it gives me an invalid password error. The log file says
that it cannot find my username (cinpet).

I am not using encrypted passwords. I have the Windows PC setup correctly
for plain text passwords. I have two to other Linux x86 PCs setup with samba
and they work fine.

My username is in the passwd, hosts, lmhosts files.

I am able to ping in both directions. I am able to run 'smbclient -L cinpet'
and see my Windows shares. I am able to login to the device through telnet
with my username.

I have run out of things that I know to try. What am I missing?

Thanks,

Cindy Peters
Adaptive Micro-ware


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
