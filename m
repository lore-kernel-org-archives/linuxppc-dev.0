From: m.venkatraj@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578601FCF4FE@ap-bang-m02.india.tek.com>
To: Torsten.Demke@fci.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: ADS860 - unable to load kernel- Bad magic number
Date: Fri, 27 Feb 2004 01:14:45 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for all the suggestions! mkimage did the trick.

Best regards
Venkatraj

> when using u-boot you need an Linux image which is
> created with "mkimage" tool.
>
> Try "make uImage" which will create this
> image in arch/ppc/boot/image.
>
> See also:
> (http://www.denx.de/twiki/bin/view/DULG/Manual)
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
