Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D6D1722.9421CC3B@redswitch.com>
Date: Wed, 28 Aug 2002 11:32:03 -0700
From: Jin Cheng <jcheng@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: root login on ELDK nfs booting
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I booted on /opt/eldk/ppc_4xx. But it does not allow root login from my
serial console.
I changed the /etc/passwd so that I can login in as adm. Anyone can give
me advice on the
problem? Thanks.

Following is my srceen out. (192.168.5.249 is my box IP)
hyperion: 124 % telnet 192.168.5.249
Trying 192.168.5.249...
Connected to 192.168.5.249.
Escape character is '^]'.

Linux 2.4.20-pre4 (192.168.5.249) (11:29 on Wednesday, 28 August 2002)

login: root
Login incorrect

login: adm
Last login: Wed Aug 28 11:15:59 from 192.168.5.58
No directory /var/adm!
Logging in with home = "/".
sh-2.04$

Regards,

Jin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
