Date: Sun, 26 Sep 1999 22:10:00 +0200 (MET DST)
From: Geert Uytterhoeven <geert@sonycom.com>
To: Anirudh Joshi <ajoshi@Glue.umd.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SndConfig for Linux/PPC
In-Reply-To: <Pine.GSO.4.10.9909241353170.4557-100000@digital.eng.umd.edu>
Message-ID: <Pine.GSO.4.10.9909262208590.11268-100000@begonia.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Sep 1999, Anirudh Joshi wrote:
> 	heh... funny you bring this up, cause just yesterday i decided
> (was coaxed rather) to rewrite the awacs driver.  hopefully when i'm
> finished, it'll be out of dmasound.c and awacs.c will be done The Right
> Way (or whatever way i think is Right :).  anyhow, it'll have all the
> goodies like mixer support, etc...

Why remove the AWACS code from damsound.c? In't it better to enhance
dmasound.c, so Amiga/Atari users benefit from your enhancements as well?

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248648 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
