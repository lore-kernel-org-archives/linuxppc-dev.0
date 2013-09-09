Return-Path: <tmusta@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B96852C0136
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2013 22:45:06 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tmusta@us.ibm.com>;
 Mon, 9 Sep 2013 06:45:03 -0600
In-Reply-To: <1378721499.11525.5.camel@pasglop>
References: <CAJ-hshaxuJBMCFquT7J50rjuDYWer_0i1=2QmnOKGAxx4n=FUw@mail.gmail.com>
 <20130908223559.GA495@iris.ozlabs.ibm.com> <1378721499.11525.5.camel@pasglop>
Subject: Re: [PATCH] powerpc: OE=1 Form Instructions Not Decoded Correctly
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF5204CF2E.B2F7FFF8-ON86257BE1.0044FF5E-86257BE1.0046077F@us.ibm.com>
From: Tom Musta <tmusta@us.ibm.com>
Date: Mon, 9 Sep 2013 07:44:54 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF172DFD779CE8f9e8a93df938690918c09BBF172DFD779CE"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Linuxppc-dev <linuxppc-dev-bounces+tmusta=us.ibm.com@lists.ozlabs.org>,
 Tom Musta <tommusta@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF172DFD779CE8f9e8a93df938690918c09BBF172DFD779CE
Content-type: text/plain; charset=US-ASCII



> Looks like the patch has been mangled by the mailer ... it's in HTML to
> begin with :-)

Frustrating.  I did use a plain text option on the mail client and did a
test send to a few accounts before posting to the mailing list.  The
patch was verified by checkpatch.pl before it got mangled.

I will find a better setup and resubmit.

> Isn't that code occasionally used with uprobes too nowadays  ?

Yes. I believe so.

Tom Musta (tmusta@us.ibm.com)
Senior Software Engineer
Blue Gene Kernel Development
IBM Rochester
(507) 253-4119   (T/L 553-4119)
--0__=09BBF172DFD779CE8f9e8a93df938690918c09BBF172DFD779CE
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><font size="2"><br>
&gt; Looks like the patch has been mangled by the mailer ... it's in HTML to<br>
&gt; begin with :-)<br>
</font></tt><br>
<tt><font size="2">Frustrating. &nbsp;I did use a plain text option on the mail client and did a </font></tt><br>
<tt><font size="2">test send to a few accounts before posting to the mailing list. &nbsp;The </font></tt><br>
<tt><font size="2">patch was verified by checkpatch.pl before it got mangled.</font></tt><br>
<br>
<tt><font size="2">I will find a better setup and resubmit.</font></tt><br>
<br>
<tt><font size="2">&gt; Isn't that code occasionally used with uprobes too nowadays &nbsp;?<br>
</font></tt><br>
<tt><font size="2">Yes. I believe so.</font></tt><br>
<br>
<font size="2" face="sans-serif">Tom Musta (tmusta@us.ibm.com)<br>
Senior Software Engineer<br>
Blue Gene Kernel Development<br>
IBM Rochester<br>
(507) 253-4119 &nbsp; (T/L 553-4119)<br>
</font></body></html>
--0__=09BBF172DFD779CE8f9e8a93df938690918c09BBF172DFD779CE--
