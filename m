Message-ID: <3D405B7F.5020200@lvl7.com>
Date: Thu, 25 Jul 2002 16:11:43 -0400
From: "John W. Linville" <linville@lvl7.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: abatron and kernel modules.
References: <200207251713.MAA00232@mint.mw.cray.com> <3D40556C.4040108@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> There was also a version of the 2.4.2 kernel, perhaps even a MontaVista
> snapshot, where I screwed up loading the address of the pte pointer

I recall having to add the BDI support to the linux-2.4.2_hhl20 kernel
source here.  If the original poster doesn't want to use a later kernel
for whatever reason (e.g. no support contract), he should get some late
2.4 source, find the BDI references (there aren't that many), and port
them back to his 2.4.2-derived base.

Good luck!

John

--
John W. Linville
LVL7 Systems, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
