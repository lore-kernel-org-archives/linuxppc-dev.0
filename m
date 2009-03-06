Return-Path: <Tom.Bucken@sybase.com>
Received: from fm200.sybase.com (fm200.sybase.com [192.138.151.122])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "fm200.sybase.com", Issuer "fm200.sybase.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B38CCDDF0F
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 07:01:49 +1100 (EST)
Received: from smtp2.sybase.com (sybgate2.sybase.com [10.22.97.85])
	by fm200.sybase.com  with ESMTP id n26JdO209378
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Mar 2009 11:39:24 -0800 (PST)
Received: from gwwest.sybase.com (localhost [127.0.0.1])
	by smtp2.sybase.com  with ESMTP id n26JdNF23871
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Mar 2009 11:39:24 -0800 (PST)
To: linuxppc-dev@ozlabs.org
Subject: backtrace_symbols
MIME-Version: 1.0
Message-ID: <OF4975E60B.03768114-ON87257571.0069F0AE-85257571.006BF81C@sybase.com>
From: Tom.Bucken@sybase.com
Date: Fri, 6 Mar 2009 14:39:15 -0500
Content-Type: multipart/alternative;
	boundary="=_alternative 006BF81B85257571_="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 006BF81B85257571_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

        I am producing stacktraces by calling backtrace to get the
stack and backtrace_symbols to print each frame.  backtrace_symbols
is returning some extra unprintable characters at the start of each
array entry.

        each array entry starts with this unprintable character (repeats
7 times followed by \n).

        0X8ff



void *arr[NUM_STACKFRAMES];
 int nSize = backtrace(arr, NUM_STACKFRAMES);
 char **sym = backtrace_symbols(arr, nSize);
  int ii;
  for (ii = 0; ii < nSize; ii++) {
     printf("%s\n", sym[ii]);
  }
  free(sym);


Is there a way to get each stack entry without seeing
the unprintable characters ?

Tom

--=_alternative 006BF81B85257571_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; I
am producing stacktraces by calling backtrace to get the</font>
<br><font size=2 face="sans-serif">stack and backtrace_symbols to print
each frame. &nbsp;backtrace_symbols</font>
<br><font size=2 face="sans-serif">is returning some extra unprintable
characters at the start of each</font>
<br><font size=2 face="sans-serif">array entry.</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; each
array entry starts with this unprintable character (repeats</font>
<br><font size=2 face="sans-serif">7 times followed by \n).</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; 0X8ff</font>
<br>
<br>
<br>
<div>
<br><font size=2 face="sans-serif">void *arr[NUM_STACKFRAMES];<br>
 int nSize = backtrace(arr, NUM_STACKFRAMES);<br>
 char **sym = backtrace_symbols(arr, nSize);<br>
 &nbsp;int ii;<br>
 &nbsp;for (ii = 0; ii &lt; nSize; ii++) {<br>
 &nbsp; &nbsp; printf(&quot;%s\n&quot;, sym[ii]);<br>
 &nbsp;}<br>
 &nbsp;free(sym);</font>
<br>
<br>
<br><font size=2 face="sans-serif">Is there a way to get each stack entry
without seeing</font>
<br><font size=2 face="sans-serif">the unprintable characters ?</font>
<br>
<br><font size=2 face="sans-serif">Tom</font>
<br></div>
--=_alternative 006BF81B85257571_=--
