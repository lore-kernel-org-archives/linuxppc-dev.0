Message-ID: <3BD5316D.9020302@capflow.com>
Date: Tue, 23 Oct 2001 10:59:25 +0200
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem using FEC on a860T
References: <sbd55c05.004@tms-pty.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>well, actually the patch worked only partially...
>
>...
>after a couple of seconds, the kernel starts scrolling
>eth0: tx queue full!.
>
Could you try the unpatched kernel, with a full duplex ethernet cable
plugged into the FEC RJ45 connector when you boot the board ?

Laurent Pinchart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
