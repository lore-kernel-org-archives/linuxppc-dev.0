Message-ID: <3D406586.9070305@embeddededge.com>
Date: Thu, 25 Jul 2002 16:54:30 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "John W. Linville" <linville@lvl7.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: abatron and kernel modules.
References: <200207251713.MAA00232@mint.mw.cray.com> <3D40556C.4040108@embeddededge.com> <3D405B7F.5020200@lvl7.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John W. Linville wrote:


> I recall having to add the BDI support to the linux-2.4.2_hhl20 kernel
> source here.

There are a couple of different versions of that kernel :-)  The first
one was all PPC except 4xx.  There was one for 4xx, where I managed to
break some of the other PPCs (sorry).  There may be later ones that
include other processor architectures.  There are minor version numbers
contained in the packages, take a look at them as they are important.
Of course, the processor specific CD packages were all correct, just
be careful when mixing from one to another (which isn't recommend).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
