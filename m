Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>,
	"'Gabriel Paubert'" <paubert@iram.es>
Cc: "Troy Benjegerdes" <hozer@drgw.net>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<linuxppc-embedded@lists.linuxppc.org>,
	"Paul Mackerras" <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
Date: Fri, 10 May 2002 07:23:54 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEMJDGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFFA00A@mail.mediatrix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


FYI: There is a 1 second timer in the 8260 that could be used. (Assuming
that I understand what you are referring to) I am not sure why m8260_setup.c
just sets/returns a global variable but there is/was a note there mentioning
the 1 second timer. This is what we are using. It is actually started in our
BIOS but could be done just as easily in the setup routine.

> My platform uses an 8260 processor, and AFAIK there is no RTC.
> The function


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
