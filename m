From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>,
	"Eugene Surovegin" <ebs@innocent.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Is the preemptive kernel patch unsafe for 8xx/PPC?
Date: Thu, 12 Dec 2002 20:12:34 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFKEALEAAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <001901c2a21d$f3f4e760$0200a8c0@jockeXP>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The patch did not apply cleanly for me using linuxppc_2_4_devel, BK label
2.4.19 final.
The following files got rejected:
	include/asm-ppc/dma.h
	include/asm-ppc/pgtable.h

It was very straight forward to apply the patches by hand. The line numbers
were a bit off.

>
> Was that the 2.4.19-2 patch? What were the bugs and have you fixed them?
>
> According to the message Robert posted on lkm is the 2.4.20-1 patch only a
> rediff of the latest 2.4.19 patch.
>
> BTW, I am on the 2_4_devel branch.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
