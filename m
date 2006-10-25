Return-Path: <michaelzwrk@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by ozlabs.org (Postfix) with ESMTP id 19D5E67CBE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 00:50:01 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i4so13990wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Oct 2006 07:50:00 -0700 (PDT)
Message-ID: <1ea6be8e0610250749j4ceee6adlf1a5fae26cb494b@mail.gmail.com>
Date: Wed, 25 Oct 2006 16:49:59 +0200
From: "Michael Zagalsky" <michaelzwrk@gmail.com>
To: "Steven Hein" <ssh@sgi.com>
Subject: Re: Using WindRiver Probe JTAG
In-Reply-To: <453F5FF2.6010307@sgi.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26375_29998187.1161787799004"
References: <1ea6be8e0610250554l5f9a431cr26f03a99574f68d9@mail.gmail.com>
	<453F5FF2.6010307@sgi.com>
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

------=_Part_26375_29998187.1161787799004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks, Steven. It does help.

On 10/25/06, Steven Hein <ssh@sgi.com> wrote:
>
> Hi Michael,
>
> We just went through this same selection process for a new project
> (MPC83xx based), and we ended up choosing the BDI2000.
> I asked WindRiver folks the same question, regarding the WR ICE
> interaction with GDB.    They told me that they do not play together,
> WR ICE uses WR proprietary communication to the debugger SW.
>
> If you're already using WR workbench, I think your only option
> is to use the WR ice.    (When we evaluated WR tools for our project,
> it seemed like going with WR is an all-or-nothing deal--and we already
> had experience with the GCC toolchains, GDB debugger, etc. So, we
> chose the GCC/GDB/BDI2000 approach).
>
> Hope this helps.
>
> Steve
>
>
> Michael Zagalsky wrote:
>
>  Hi guys.
> I'd like to know if anybody had an experience using Wind River Probe JTAG
> with PowerPC architecture in general, and with PowerQuicc iii family in
> particular.
> We're using WR workbench, but I am not sure whether to use their JTAG or
> the popular BDI2000.
> Does anybody know if WR Probe uses GDB, or something proprietary to WR?
> Can it be attached to gdb/ddd/eclipse, or only to WR workbench IDE?
> For kernel debugging with symbolic information - can it use any binary
> compiled with -g, or it has to be compiled under WR workbench environment
> that has some add-ons (I know, it sounds strange - but I actually heard some
> vague saying of this kind from WR representative).
>
> I know those are questions that should be addressed to Wind River , which
> I did, but I didn't get clear enough answers - so your (good/bad) field
> experience could be very helpful.
>
> Thanks a lot,
> Michael
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing listLinuxppc-embedded@ozlabs.orghttps://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
> --
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
> Silicon Graphics, Inc.
> 1168 Industrial Blvd.                 Phone: (715) 726-8410
> Chippewa Falls, WI 54729              Fax:   (715) 726-6715
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>

------=_Part_26375_29998187.1161787799004
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks, Steven. It does help.<br><br>
<div><span class="gmail_quote">On 10/25/06, <b class="gmail_sendername">Steven Hein</b> &lt;<a href="mailto:ssh@sgi.com">ssh@sgi.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div text="#000000" bgcolor="#ffffff">Hi Michael,<br><br>We just went through this same selection process for a new project<br>(MPC83xx based), and we ended up choosing the BDI2000.<br>I asked WindRiver folks the same question, regarding the WR ICE
<br>interaction with GDB.&nbsp;&nbsp;&nbsp; They told me that they do not play together,<br>WR ICE uses WR proprietary communication to the debugger SW.<br><br>If you're already using WR workbench, I think your only option<br>is to use the WR ice.&nbsp;&nbsp;&nbsp; (When we evaluated WR tools for our project,
<br>it seemed like going with WR is an all-or-nothing deal--and we already<br>had experience with the GCC toolchains, GDB debugger, etc. So, we<br>chose the GCC/GDB/BDI2000 approach).<br><br>Hope this helps.<br><br>Steve<br>
<br><br>Michael Zagalsky wrote: 
<blockquote cite="http://mid1ea6be8e0610250554l5f9a431cr26f03a99574f68d9@mail.gmail.com" type="cite">
<div><span class="e" id="q_10e7f8ed0020b120_1">
<div>Hi guys.</div>
<div>I'd like to know if anybody had an experience&nbsp;using Wind River Probe JTAG with PowerPC architecture in general, and with PowerQuicc iii family in particular.</div>
<div>We're using WR workbench, but I am not sure whether to use their JTAG or the popular BDI2000.</div>
<div>Does anybody know if WR Probe uses GDB, or something proprietary to WR?</div>
<div>Can it be attached to gdb/ddd/eclipse, or only to WR workbench IDE?</div>
<div>For kernel debugging with symbolic information - can it use any binary compiled with -g, or it has to be compiled under WR workbench environment that has some add-ons (I know, it sounds strange - but I actually heard some vague saying of this kind from WR representative). 
</div>
<div>&nbsp;</div>
<div>I know those are questions that should be addressed to Wind River , which I did, but I didn't get clear enough answers - so your (good/bad) field experience could be very helpful.</div>
<div>&nbsp;</div>
<div>Thanks a lot, </div>
<div>Michael</div></span></div><pre><hr width="90%" size="4">
_______________________________________________
Linuxppc-embedded mailing list
<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Linuxppc-embedded@ozlabs.org" target="_blank">Linuxppc-embedded@ozlabs.org</a>
<a onclick="return top.js.OpenExtLink(window,event,this)" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre></blockquote><br><br><pre cols="72">
-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:ssh@sgi.com" target="_blank">ssh@sgi.com</a>)              Engineering Diagnostics/Software
Silicon Graphics, Inc.                          
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</pre></div></blockquote></div><br>

------=_Part_26375_29998187.1161787799004--
