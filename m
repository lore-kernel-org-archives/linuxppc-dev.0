Message-ID: <619D608DD3F0D311882C009027732E1A8B1779@ntserver.act.domain>
From: Mark Anderson <mark.anderson@adcomtech.net>
To: "'Kapil Konde '" <kapilkk@yahoo.com>,
	"'Linuxppc-Embedded '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Bad Magic Number
Date: Wed, 3 Oct 2001 19:34:50 +1000 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did you wrap the kernel image using the ppcboot
mkimage tool? If not, have a look at the ppcboot
documentation on mkimage it explains everything
you need to know.

Mark Anderson.
Advanced Communications Technologies

-----Original Message-----
From: Kapil Konde
To: Linuxppc-Embedded
Sent: 10/3/01 7:09 PM
Subject: Bad Magic Number


Hi all,
	I am trying to boot linux on my custom mpc8xx card. I have
ppcboot loaded
and I am loading linux kernel image using tftp. When I say bootm it
gives me
error "Bad Magic Number".
Can anybody please explain the error and suggest any solution for it.

Thanks in advance,
Kapilk.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
