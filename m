Message-ID: <012d01c23752$9fc4b570$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <ghannon@cspi.com>, <linuxppc-embedded@lists.linuxppc.org>
References: <85256C01.006330D5.00@pine.cspi.com>
Subject: Re: VME driver (Universe II)
Date: Tue, 30 Jul 2002 07:52:31 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did you try the driver on http://www.vmelinux.org/?
It works fine for System Controller boards.
You should make some change to support big-endian.
-Sangmoon Kim-

----- Original Message -----
From: <ghannon@cspi.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, July 26, 2002 3:16 AM
Subject: VME driver (Universe II)


>
> Greetings,
>
> Has the universe II driver been updated against the 2_4_devel tree?
>
> I have found the patches from Gabriel Paubert, against 2_2.
> Should I attempt to merge that into the 2.4.11 area to get a
> driver for VME?   It would be a learning experience for me, but
> one that I'd rather avoid if possible.
>
> The board is MVME-5100 using 2.4.11 from the devel tree.
>
> Any pointers would be appreciated.
>
> Thanks,
> Gary
>
> Gary Hannon
> CSPI
> (978)663-7598 x1509
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
