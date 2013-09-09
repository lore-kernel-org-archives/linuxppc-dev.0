Return-Path: <tmusta@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 66B1D2C0100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 06:21:10 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tmusta@us.ibm.com>;
 Mon, 9 Sep 2013 14:21:07 -0600
In-Reply-To: <OF5204CF2E.B2F7FFF8-ON86257BE1.0044FF5E-86257BE1.0046077F@us.ibm.com>
References: <CAJ-hshaxuJBMCFquT7J50rjuDYWer_0i1=2QmnOKGAxx4n=FUw@mail.gmail.com>
 <20130908223559.GA495@iris.ozlabs.ibm.com> <1378721499.11525.5.camel@pasglop>
 <OF5204CF2E.B2F7FFF8-ON86257BE1.0044FF5E-86257BE1.0046077F@us.ibm.com>
Subject: Re: [PATCH] powerpc: OE=1 Form Instructions Not Decoded Correctly
To: Tom Musta <tmusta@us.ibm.com>
Message-ID: <OF8A394047.DEDB25DC-ON86257BE1.0062D6C5-86257BE1.006FC8B8@us.ibm.com>
From: Tom Musta <tmusta@us.ibm.com>
Date: Mon, 9 Sep 2013 15:20:58 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF172DFF150558f9e8a93df938690918c09BBF172DFF15055"
Cc: linuxppc-dev@lists.ozlabs.org,
 Linuxppc-dev <linuxppc-dev-bounces+tmusta=us.ibm.com@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Tom Musta <tommusta@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF172DFF150558f9e8a93df938690918c09BBF172DFF15055
Content-type: text/plain; charset=US-ASCII

> > Isn't that code occasionally used with uprobes too nowadays  ?
>
> Yes. I believe so.

I'm going to back-pedal a little.  I reread code and can connect
single step code to kprobes but not necessarily to uprobes.  So
I am not sure that this code is used with uprobes.

--0__=09BBF172DFF150558f9e8a93df938690918c09BBF172DFF15055
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><font size="2">&gt; &gt; Isn't that code occasionally used with uprobes too nowadays &nbsp;?<br>
&gt; <br>
&gt; Yes. I believe so.<br>
</font></tt><br>
<tt><font size="2">I'm going to back-pedal a little. &nbsp;I reread code and can connect </font></tt><br>
<tt><font size="2">single step code to kprobes but not necessarily to uprobes. &nbsp;So</font></tt><br>
<tt><font size="2">I am not sure that this code is used with uprobes.</font></tt><br>
<br>
</body></html>
--0__=09BBF172DFF150558f9e8a93df938690918c09BBF172DFF15055--
