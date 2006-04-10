Return-Path: <bwarren@qstreams.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 3427C67A60
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 06:23:31 +1000 (EST)
Subject: Re: GPIO endianness on MPC8349
From: Ben Warren <bwarren@qstreams.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6518EE00-812C-4839-AF00-AA976C35E799@kernel.crashing.org>
References: <1144698501.972.103.camel@saruman.qstreams.net>
	<6518EE00-812C-4839-AF00-AA976C35E799@kernel.crashing.org>
Content-Type: multipart/alternative; boundary="=-COjB6G4tG7SKsdMisbPa"
Date: Mon, 10 Apr 2006 16:20:20 -0400
Message-Id: <1144700420.972.112.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-COjB6G4tG7SKsdMisbPa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry for wasting bandwidth (again).  Turns out my schematic is for an
earlier spin of the board.

regards,
Ben

On Mon, 2006-04-10 at 15:06 -0500, Kumar Gala wrote:

> On Apr 10, 2006, at 2:48 PM, Ben Warren wrote:
> 
> > Hello,
> >
> > I'm a noobie to this CPU, and am utterly confused with how the bits  
> > are
> > ordered on the GPIO ports.  I imagine it's the same as all Freescale
> > PPCs, but who knows.  Anyway...
> >
> > Using an MPC8349MDS eval board, I have one LED to play with.  From the
> > schematic, it's connected to GPIO1[1].  From other processors that  
> > I've
> > worked with, I would have expected to toggle it with either 0x40000000
> > (IBM 405) or 0x00000002 (68360).  Nope.  To make this bit move, I mess
> > with bit 0x00000040 in the appropriate DAT register.  This leads me to
> > believe that either the bit ordering is something
> > like ...89abcdef01234567 (sorry for the confusing notation, but
> > hopefully it makes sense) or the schematic has a typo.  Since I'm  
> > trying
> > to write a generic GPIO handler, I'd like to have a little  
> > confidence in
> > my extrapolation from a single point.
> >
> > Can anybody shed some light on this?
> 
> This is because the Freescale docs are misleading.  If you look at  
> the schematic you will see the LED is wired to GPIO1[5] which makes  
> sense for the 0x40 value you have to use.
> 
> - kumar

--=-COjB6G4tG7SKsdMisbPa
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.8.1">
</HEAD>
<BODY>
Sorry for wasting bandwidth (again).&nbsp; Turns out my schematic is for an earlier spin of the board.<BR>
<BR>
regards,<BR>
Ben<BR>
<BR>
On Mon, 2006-04-10 at 15:06 -0500, Kumar Gala wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">On Apr 10, 2006, at 2:48 PM, Ben Warren wrote:</FONT>

<FONT COLOR="#000000">&gt; Hello,</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; I'm a noobie to this CPU, and am utterly confused with how the bits  </FONT>
<FONT COLOR="#000000">&gt; are</FONT>
<FONT COLOR="#000000">&gt; ordered on the GPIO ports.  I imagine it's the same as all Freescale</FONT>
<FONT COLOR="#000000">&gt; PPCs, but who knows.  Anyway...</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; Using an MPC8349MDS eval board, I have one LED to play with.  From the</FONT>
<FONT COLOR="#000000">&gt; schematic, it's connected to GPIO1[1].  From other processors that  </FONT>
<FONT COLOR="#000000">&gt; I've</FONT>
<FONT COLOR="#000000">&gt; worked with, I would have expected to toggle it with either 0x40000000</FONT>
<FONT COLOR="#000000">&gt; (IBM 405) or 0x00000002 (68360).  Nope.  To make this bit move, I mess</FONT>
<FONT COLOR="#000000">&gt; with bit 0x00000040 in the appropriate DAT register.  This leads me to</FONT>
<FONT COLOR="#000000">&gt; believe that either the bit ordering is something</FONT>
<FONT COLOR="#000000">&gt; like ...89abcdef01234567 (sorry for the confusing notation, but</FONT>
<FONT COLOR="#000000">&gt; hopefully it makes sense) or the schematic has a typo.  Since I'm  </FONT>
<FONT COLOR="#000000">&gt; trying</FONT>
<FONT COLOR="#000000">&gt; to write a generic GPIO handler, I'd like to have a little  </FONT>
<FONT COLOR="#000000">&gt; confidence in</FONT>
<FONT COLOR="#000000">&gt; my extrapolation from a single point.</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; Can anybody shed some light on this?</FONT>

<FONT COLOR="#000000">This is because the Freescale docs are misleading.  If you look at  </FONT>
<FONT COLOR="#000000">the schematic you will see the LED is wired to GPIO1[5] which makes  </FONT>
<FONT COLOR="#000000">sense for the 0x40 value you have to use.</FONT>

<FONT COLOR="#000000">- kumar</FONT>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-COjB6G4tG7SKsdMisbPa--
