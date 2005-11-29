Return-Path: <kernel-stuff@comcast.net>
Received: from rwcrmhc11.comcast.net (rwcrmhc11.comcast.net [204.127.198.35])
	by ozlabs.org (Postfix) with ESMTP id EF1AE687FD
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2005 17:13:21 +1100 (EST)
In-Reply-To: <20051129000615.GA20843@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	<70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
	<20051129000615.GA20843@hansmi.ch>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: multipart/alternative; boundary=Apple-Mail-1-318637720
Message-Id: <68465DDA-053F-4A85-9204-549E830B2269@comcast.net>
From: Parag Warudkar <kernel-stuff@comcast.net>
Date: Tue, 29 Nov 2005 01:11:00 -0500
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PowerBook5,8 - TrackPad update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Apple-Mail-1-318637720
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Nov 28, 2005, at 7:06 PM, Michael Hanselmann wrote:

> The product ID I have, 0x0215, was in none of the
> available drivers and the data format is somewhat different

Hi Michael

Is yours the 15" model or the 17"? Mine is 15" and the product id is  
0x0214.

> You find my hacked version attached -- be aware that in its current  
> form
> it will not work with any touchpad except 0x0215.

I haven't looked at your changes completely yet but are you saying it  
works? Meaning mouse
moves properly?

Also I find it strange that your model requires 80 bytes ATP_DATASIZE  
- mine isn't happy
at all with anything less than 256. The less number of sensors you  
defined is again a puzzle.

> As far as I see it, all methods can be built into one driver. Is there
> already someone working on combining them?

If the format of the data is same (which looks like it is with your  
model) then yes, but in my case
the data arrives is 64 byte blocks - there are 4 of them in one  
transfer, each a reading on it's own.

Hmm. More confusion.

Thanks

Parag
--Apple-Mail-1-318637720
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><BR><DIV><DIV>On Nov 28, 2005, =
at 7:06 PM, Michael Hanselmann wrote:</DIV><BR =
class=3D"Apple-interchange-newline"><BLOCKQUOTE type=3D"cite"><P =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><FONT face=3D"Futura" size=3D"5"=
 style=3D"font: 16.0px Futura">The product ID I have, 0x0215, was in =
none of the</FONT></P> <P style=3D"margin: 0.0px 0.0px 0.0px =
0.0px"><FONT face=3D"Futura" size=3D"5" style=3D"font: 16.0px =
Futura">available drivers and the data format is somewhat =
different</FONT></P> </BLOCKQUOTE></DIV><BR><DIV>Hi =
Michael</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Is=A0yours the 15" model or =
the 17"? Mine is 15" and the product id is 0x0214.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><BLOCKQUOTE type=3D"cite"><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">You find my hacked version attached -- be aware that =
in its current form</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">it will not work with any =
touchpad except 0x0215.</DIV></BLOCKQUOTE><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I haven't looked at your =
changes completely yet but are you saying it works? Meaning =
mouse=A0</DIV><DIV>moves properly?=A0=A0</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Also I find it strange that =
your model requires 80 bytes ATP_DATASIZE - mine isn't =
happy</DIV><DIV>at all with anything less than 256. The less number of =
sensors you defined is again a puzzle.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><BLOCKQUOTE type=3D"cite"><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">As far as I see it, all methods can be built into =
one driver. Is there</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">already someone working on =
combining them?</DIV></BLOCKQUOTE><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>If the format of the data is =
same (which looks like it is with your model) then yes, but in my =
case=A0<DIV>the data arrives is 64 byte blocks - there are 4 of them in =
one transfer, each a reading on it's own.<BR><BR>Hmm. More =
confusion.=A0</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Thanks</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Parag</DIV></BODY></HTML>=

--Apple-Mail-1-318637720--
