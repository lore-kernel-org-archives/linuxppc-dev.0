From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: asm-ppc/io.h - 8260 conditional compile?
Date: Tue, 6 Aug 2002 07:04:05 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEGHDKAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3D4FD042.5070405@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > It appears to me that the inline functions in this file are missing the
> > CONFIG_8260 conditional compile. Can anyone confirm if this it true?
>
> I can confirm it is not true.  What would need to change for 8260?  It
> has worked for a long time.

Nothing needs to change to the 8260, it should be implemented like the 8xx
and 4xx processors, which it isn't without the conditional compiles. (It
appears to work either way)  I do not see corresponding conditional compiles
in pgtable.c or the other mm/*.c which would indicate that the 8260 memory
management is implemented differently.

8260 memory translations were broken in HHL 2.0 (Linux 2.4.2) Just making
sure it isn't still broken in 2.4.17


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
