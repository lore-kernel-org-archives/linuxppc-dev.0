Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D654892.30500@redswitch.com>
Date: Thu, 22 Aug 2002 13:24:50 -0700
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: fast ethernet LXT972A support
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed that only LXT970 and 971 are supported in the lastest kernel
distribution from DENX. But the comments in fec.c say "includes support
for following PHYs: QS6612, LXT970, LXT971/2". Does it mean that LXT972
can use 971's driver? If not, basically what kind of modification is
needed? Thanks.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
