Return-Path: <alancarbr@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id C06AD6886F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 06:30:23 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i5so154258wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 05 Dec 2005 11:30:22 -0800 (PST)
Message-ID: <dc70db7d0512051130s498f7d5fk42a0f4886c006efd@mail.gmail.com>
Date: Mon, 5 Dec 2005 17:30:22 -0200
From: Alan Carvalho <alancarbr@gmail.com>
To: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20561_32994675.1133811022103"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Video Card to Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_20561_32994675.1133811022103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Denx,
I am just looking for a cheaper video card to use with Lite5200 board.
CoralP is very expansive, then I will use ATI Rage Mobility.

I see some reference to this board at:
http://ozlabs.org/pipermail/linuxppc-embedded/2004-July/014848.html

Here in Brazil I get an "ATI RAGE XL 8MB PCI" (ATI Mobility 8M TV PCI),
it is PCI v. 2.2 (support 3.3V and 5V).

But I found some tips here at ozlabs:

"Other possible problem is that i found with ATI Rage Mobility M1 EVA board
that it's 723 3.3V regulator needed as default +12V to operate."

Well, my video card is not ATI Rage Mobility M1 EVA, it has not 723
regulator, it use MTD3302 as regulator, do you know if I need change
something on the Lite5200's PCI slot to it work with this video card?

My Lite5200 is Version 2.0, and Freescale connected some wire (small cables=
)
to PCI slot, maybe to fix some PCI problems.

I am using linux kernel 2.6.14, downloaded from denx's web site. Linux is
running fine in this board, but until now I am using only serial console.
Now I want use a video card with it.

Best regards,

Alan

------=_Part_20561_32994675.1133811022103
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Denx,<br>
I am just looking for a cheaper video card to use with Lite5200 board.<br>
CoralP is very expansive, then I will use ATI Rage Mobility.<br>
<br>
I see some reference to this board at:<br>
<a href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-July/014848.h=
tml" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,th=
is)">http://ozlabs.org/pipermail/linuxppc-embedded/2004-July/014848.html</a=
>
<br>
<br>
Here in Brazil I get an &quot;ATI RAGE XL 8MB PCI&quot; (ATI Mobility 8M TV=
 PCI), <br>
it is PCI v. 2.2 (support 3.3V and 5V).<br>
<br>
But I found some tips here at ozlabs:<br>
<br>
&quot;Other possible problem is that i found with ATI Rage Mobility M1 EVA =
board<span style=3D"font-family: monospace;"><br>
</span>that it's 723 3.3V regulator needed as default +12V to operate.&quot=
;<br>
<br>
Well, my video card is not ATI Rage Mobility M1 EVA, it has not 723
regulator, it use MTD3302 as regulator, do you know if I need change
something on the Lite5200's PCI slot to it work with this video card?<br>
<br>
My Lite5200 is Version 2.0, and Freescale connected some wire (small cables=
) to PCI slot, maybe to fix some PCI problems.<br>
<br>
I am using linux kernel 2.6.14, downloaded from denx's web site. Linux
is running fine in this board, but until now I am using only serial
console. <br>
Now I want use a video card with it.<br>
<br>
Best regards,<br>
<br>
Alan<br>


------=_Part_20561_32994675.1133811022103--
