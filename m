From: diekema_jon <diekema@lucky.si.com>
Message-Id: <200208091838.OAA14194@lucky.si.com>
Subject: Re: /dev/flash and MTD
To: xjin@redswitch.com ("Xiaogeng (Shawn) Jin")
Date: Fri, 9 Aug 2002 14:38:45 -0400 (EDT)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3D540B52.8080709@redswitch.com> from "Xiaogeng (Shawn) Jin" at Aug 09, 2002 11:34:58 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> To enable MTD on a board, do we still need /dev/flash?

No.

> In other words, is there any relationship between /dev/flash and
> MTD? I found that only on Denx distribution of 2.4.4 there is such a
> device '/dev/flash'. Thanks.

The /dev/flash device entries use a stand alone flash driver that
isn't part of MTD.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
