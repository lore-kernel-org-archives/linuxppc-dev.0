Message-ID: <001c01c24df2$76195030$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "Jin Cheng" <jcheng@redswitch.com>,
	"Matt Porter" <porter@cox.net>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <3D6BB90D.FEA66532@redswitch.com>
Subject: Re: Downloading Image
Date: Tue, 27 Aug 2002 23:22:07 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jin

The eval kit for IBM PPC 440 has OpenBios as the rom monitor code. I
compiled the PPC kernel with Mvista 405 compiler. As Matt Porter suggested,
I download the zImage.ebony using the TFTP. The Image is downloaded to 440
board, however finally it says PPC unknown. I trying some sample application
on the ebony board now.

Regards
Aman

----- Original Message -----
From: "Jin Cheng" <jcheng@redswitch.com>
To: "Matt Porter" <porter@cox.net>
Cc: "Aman" <aman@mistralsoftware.com>; "linuxppc embedded"
<linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, August 27, 2002 11:08 PM
Subject: Re: Downloading Image


> Hi,
>
> I am wondering whether can use the OpenBIOS coming with the 440GP Ebony
> board
> to load the linux kernel or there is a ppcboot for Ebony which can do
> that? Thanks.
>
> Sincerely,
>
> Jin
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
