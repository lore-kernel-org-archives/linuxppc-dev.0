Return-Path: <ryanarn@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0063B2C015B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2013 01:18:34 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ryanarn@us.ibm.com>;
 Tue, 7 May 2013 09:18:32 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DF70A3E4008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 09:18:11 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r47FIDnm058310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 09:18:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r47FI9NU001149
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 09:18:09 -0600
In-Reply-To: <1367876228.15842.62.camel@pasglop>
References: <20130503231933.GA29436@linux.vnet.ibm.com>	
 <1367623431.4389.132.camel@pasglop>
 <20130503234019.GE8561@linux.vnet.ibm.com>	
 <OFBCA2593E.F64367AB-ON86257B63.004ED7A8-86257B63.00506FC6@us.ibm.com>
 <1367876228.15842.62.camel@pasglop>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR,
 EBB and ISEL bits in HWCAP2
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF50BAF8AD.66579817-ON86257B64.00532B5A-86257B64.00535E3F@us.ibm.com>
From: Ryan Arnold <ryanarn@us.ibm.com>
Date: Tue, 7 May 2013 10:11:41 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF1F7DFC0ADCA8f9e8a93df938690918c09BBF1F7DFC0ADCA"
Cc: linuxppc-dev@lists.ozlabs.org, Michael R Meissner <mrmeissn@us.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF1F7DFC0ADCA8f9e8a93df938690918c09BBF1F7DFC0ADCA
Content-type: text/plain; charset=US-ASCII

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/06/2013
04:37:08 PM:

> Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 05/06/2013 04:37 PM
>
> To
>
> Ryan Arnold/Rochester/IBM@IBMUS
>
> cc
>
> Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, linuxppc-
> dev@lists.ozlabs.org, Michael R Meissner/Cambridge/IBM@IBMUS,
> Michael Neuling <michael.neuling@au1.ibm.com>, Peter Bergner/
> Rochester/IBM@IBMUS, Steve Munroe/Rochester/IBM@IBMUS
>
> Subject
>
> Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and ISEL
> bits in HWCAP2
>
> On Mon, 2013-05-06 at 09:38 -0500, Ryan Arnold wrote:
> > My understanding was that these bits being 'on' is an indication of
> > what features the hardware supports (or what the kernel emulates) and
> > a not an indication of whether that facility is currently enabled or
> > not.  If the hardware supports a particular feature but it is not
> > enabled I'd expect that user-space usage of that feature would cause
> > the kernel to trap on a facility availability exception (which is how
> > Altivec/VMX is implemented, being defaulted to turned off).
>
> Right but the discussion is about whether we should expose the bits
> when the kernel doesn't have the ability to handle the feature :-)
>
> IE. We need to remove the HTM feature if the kernel is compiled without
> transactional memory support.

Thanks for explaining. This is exactly how it should work.

Ryan
--0__=09BBF1F7DFC0ADCA8f9e8a93df938690918c09BBF1F7DFC0ADCA
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><font size="2">Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt; wrote on 05/06/2013 04:37:08 PM:<br>
<br>
&gt; Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt; </font></tt><br>
<tt><font size="2">&gt; 05/06/2013 04:37 PM</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; To</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Ryan Arnold/Rochester/IBM@IBMUS</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; cc</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Nishanth Aravamudan &lt;nacc@linux.vnet.ibm.com&gt;, linuxppc-<br>
&gt; dev@lists.ozlabs.org, Michael R Meissner/Cambridge/IBM@IBMUS, <br>
&gt; Michael Neuling &lt;michael.neuling@au1.ibm.com&gt;, Peter Bergner/<br>
&gt; Rochester/IBM@IBMUS, Steve Munroe/Rochester/IBM@IBMUS</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Subject</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and ISEL<br>
&gt; bits in HWCAP2</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; On Mon, 2013-05-06 at 09:38 -0500, Ryan Arnold wrote:<br>
&gt; &gt; My understanding was that these bits being 'on' is an indication of<br>
&gt; &gt; what features the hardware supports (or what the kernel emulates) and<br>
&gt; &gt; a not an indication of whether that facility is currently enabled or<br>
&gt; &gt; not. &nbsp;If the hardware supports a particular feature but it is not<br>
&gt; &gt; enabled I'd expect that user-space usage of that feature would cause<br>
&gt; &gt; the kernel to trap on a facility availability exception (which is how<br>
&gt; &gt; Altivec/VMX is implemented, being defaulted to turned off).<br>
&gt; <br>
&gt; Right but the discussion is about whether we should expose the bits<br>
&gt; when the kernel doesn't have the ability to handle the feature :-)<br>
&gt; <br>
&gt; IE. We need to remove the HTM feature if the kernel is compiled without<br>
&gt; transactional memory support.</font></tt><br>
<br>
<tt><font size="2">Thanks for explaining. This is exactly how it should work.</font></tt><br>
<br>
<tt><font size="2">Ryan</font></tt><br>
</body></html>
--0__=09BBF1F7DFC0ADCA8f9e8a93df938690918c09BBF1F7DFC0ADCA--
