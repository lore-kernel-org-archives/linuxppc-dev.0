Message-ID: <003e01c3c2bb$18416e40$5100a8c0@davey033ce6193>
From: "DaveyWu" <daveywu@transengines.com>
To: "sun" <sun-zj@tdk-tech.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <000f01c3c2b7$aa15e070$3901a8c0@sunzj>
Subject: Re: How can I move to newer kernel??
Date: Mon, 15 Dec 2003 11:25:19 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sun,
You should modify the Makefile and set ARCH=ppc,
CROSS_COMPILE=$(yourcompiler) then make menuconfig. In platform select
8xx for processor type, FADS for machine type.

Best regards,
Davey

----- Original Message -----
From: "sun" <sun-zj@tdk-tech.com>
Sent: Monday, December 15, 2003 11:00 AM
Subject: How can I move to newer kernel??

>    I am working on running linux on PPC 860T(Motorola ). I used the
> kernel2.4.4 from Denx which works fine(thank Denx).I want to use the
> newly kernel version e.g. the 2.4.1x,2.4.2x or 2.6.xx. I am using
> the FADS860 boards. I have download the PPC kernel from bitkeeper as
> http://penguinppc.org/ told us. but how can I compile it? I can not
> find a FADS860_config option. How can I get that?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
