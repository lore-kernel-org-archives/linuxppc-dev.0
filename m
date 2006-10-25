Return-Path: <ssh@sgi.com>
Received: from omx1.americas.sgi.com (omx1-ext.sgi.com [192.48.179.11])
	by ozlabs.org (Postfix) with ESMTP id 3802E67C4F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Oct 2006 23:00:37 +1000 (EST)
Message-ID: <453F5FF2.6010307@sgi.com>
Date: Wed, 25 Oct 2006 08:00:34 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: Michael Zagalsky <michaelzwrk@gmail.com>
Subject: Re: Using WindRiver Probe JTAG
References: <1ea6be8e0610250554l5f9a431cr26f03a99574f68d9@mail.gmail.com>
In-Reply-To: <1ea6be8e0610250554l5f9a431cr26f03a99574f68d9@mail.gmail.com>
Content-Type: text/html; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Michael,<br>
<br>
We just went through this same selection process for a new project<br>
(MPC83xx based), and we ended up choosing the BDI2000.<br>
I asked WindRiver folks the same question, regarding the WR ICE<br>
interaction with GDB.&nbsp;&nbsp;&nbsp; They told me that they do not play together,<br>
WR ICE uses WR proprietary communication to the debugger SW.<br>
<br>
If you're already using WR workbench, I think your only option<br>
is to use the WR ice.&nbsp;&nbsp;&nbsp; (When we evaluated WR tools for our project,<br>
it seemed like going with WR is an all-or-nothing deal--and we already<br>
had experience with the GCC toolchains, GDB debugger, etc. So, we<br>
chose the GCC/GDB/BDI2000 approach).<br>
<br>
Hope this helps.<br>
<br>
Steve<br>
<br>
<br>
Michael Zagalsky wrote:
<blockquote
 cite="mid1ea6be8e0610250554l5f9a431cr26f03a99574f68d9@mail.gmail.com"
 type="cite">
  <div>Hi guys.</div>
  <div>I'd like to know if anybody had an experience&nbsp;using Wind River
Probe JTAG with PowerPC architecture in general, and with PowerQuicc
iii family in particular.</div>
  <div>We're using WR workbench, but I am not sure whether to use their
JTAG or the popular BDI2000.</div>
  <div>Does anybody know if WR Probe uses GDB, or something proprietary
to WR?</div>
  <div>Can it be attached to gdb/ddd/eclipse, or only to WR workbench
IDE?</div>
  <div>For kernel debugging with symbolic information - can it use any
binary compiled with -g, or it has to be compiled under WR workbench
environment that has some add-ons (I know, it sounds strange - but I
actually heard some vague saying of this kind from WR representative).
  </div>
  <div>&nbsp;</div>
  <div>I know those are questions that should be addressed to Wind
River , which I did, but I didn't get clear enough answers - so your
(good/bad) field experience could be very helpful.</div>
  <div>&nbsp;</div>
  <div>Thanks a lot, </div>
  <div>Michael</div>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (<a class="moz-txt-link-abbreviated" href="mailto:ssh@sgi.com">ssh@sgi.com</a>)              Engineering Diagnostics/Software
Silicon Graphics, Inc.                          
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</pre>
</body>
</html>
