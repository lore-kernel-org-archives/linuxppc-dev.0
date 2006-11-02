Return-Path: <stevewin@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5DF2167B6C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 02:32:58 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA2FWtWn028981
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Nov 2006 10:32:55 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA2FWtQU475806
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Nov 2006 08:32:55 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA2FWt28010674
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Nov 2006 08:32:55 -0700
In-Reply-To: <528646bc0611020658le3adc94p30f372f3a1a8b07e@mail.gmail.com>
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <OF4DAC86D4.8F202745-ON8725721A.00550DB9-8525721A.00556835@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Thu, 2 Nov 2006 10:32:53 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBF889DFC68B298f9e8a93df938690918c08BBF889DFC68B29"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBF889DFC68B298f9e8a93df938690918c08BBF889DFC68B29
Content-type: text/plain; charset=US-ASCII





linuxppc-dev-bounces+stevewin=us.ibm.com@ozlabs.org wrote on 11/02/2006
09:58:39 AM:

> On 11/2/06, s.hauer@pengutronix.de <s.hauer@pengutronix.de> wrote:
> > remove EMBEDDED6xx Kconfig entry
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > Index: linux-2.6/arch/powerpc/Kconfig
> > ===================================================================
> > --- linux-2.6.orig/arch/powerpc/Kconfig
> > +++ linux-2.6/arch/powerpc/Kconfig
> > @@ -338,10 +338,6 @@ config PPC_MULTIPLATFORM
> >           RS/6000 machine, an Apple machine, or a PReP, CHRP,
> >           Maple or Cell-based machine.
> >
> > -config EMBEDDED6xx
> > -       bool "Embedded 6xx/7xx/7xxx-based board"
> > -       depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
> > -
> >  config APUS
> >         bool "Amiga-APUS"
> >         depends on PPC32 && BROKEN
> >
> > --
>
> If you do this, then where should embedded 6xx board ports go?  For
> example; mpc52xx for which there are currently patches on the mailing
> list.
>
> g.
>
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

I also have a question about 750xx platforms.  I currently am looking at
adding platform code supporting IBM 750GX/CL eval boards.  Where would they
go - as well as others like Buckeye/Chestnut if/when they move over to
/powerpc?
--0__=08BBF889DFC68B298f9e8a93df938690918c08BBF889DFC68B29
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>linuxppc-dev-bounces+stevewin=us.ibm.com@ozlabs.org wrote on 11/02/2006 09:58:39 AM:<br>
<br>
&gt; On 11/2/06, s.hauer@pengutronix.de &lt;s.hauer@pengutronix.de&gt; wrote:<br>
&gt; &gt; remove EMBEDDED6xx Kconfig entry<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Sascha Hauer &lt;s.hauer@pengutronix.de&gt;<br>
&gt; &gt;<br>
&gt; &gt; Index: linux-2.6/arch/powerpc/Kconfig<br>
&gt; &gt; ===================================================================<br>
&gt; &gt; --- linux-2.6.orig/arch/powerpc/Kconfig<br>
&gt; &gt; +++ linux-2.6/arch/powerpc/Kconfig<br>
&gt; &gt; @@ -338,10 +338,6 @@ config PPC_MULTIPLATFORM<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RS/6000 machine, an Apple machine, or a PReP, CHRP,<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Maple or Cell-based machine.<br>
&gt; &gt;<br>
&gt; &gt; -config EMBEDDED6xx<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; bool &quot;Embedded 6xx/7xx/7xxx-based board&quot;<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; depends on PPC32 &amp;&amp; (BROKEN||BROKEN_ON_SMP)<br>
&gt; &gt; -<br>
&gt; &gt; &nbsp;config APUS<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; bool &quot;Amiga-APUS&quot;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; depends on PPC32 &amp;&amp; BROKEN<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; <br>
&gt; If you do this, then where should embedded 6xx board ports go? &nbsp;For<br>
&gt; example; mpc52xx for which there are currently patches on the mailing<br>
&gt; list.<br>
&gt; <br>
&gt; g.<br>
&gt; <br>
&gt; -- <br>
&gt; Grant Likely, B.Sc. P.Eng.<br>
&gt; Secret Lab Technologies Ltd.<br>
&gt; grant.likely@secretlab.ca<br>
&gt; (403) 399-0195<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; Linuxppc-dev@ozlabs.org<br>
&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a></tt><br>
<br>
<tt>I also have a question about 750xx platforms. &nbsp;I currently am looking at adding platform code supporting IBM 750GX/CL eval boards. &nbsp;Where would they go - as well as others like Buckeye/Chestnut if/when they move over to /powerpc?<br>
</tt></body></html>
--0__=08BBF889DFC68B298f9e8a93df938690918c08BBF889DFC68B29--
