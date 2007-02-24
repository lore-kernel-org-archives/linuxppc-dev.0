Return-Path: <wmaxfield@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.235])
	by ozlabs.org (Postfix) with ESMTP id 1C144DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Feb 2007 09:40:55 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so909605nzf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 14:40:54 -0800 (PST)
Message-ID: <45a1b53e0702241440y76024946w20ba32658460388c@mail.gmail.com>
Date: Sat, 24 Feb 2007 16:40:54 -0600
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: Re: debugging custom Xilinx boot loader with abatron and Montavista
	devrocket
In-Reply-To: <1172267591.13040.30.camel@jaalaptop>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_78929_6725060.1172356854055"
References: <45a1b53e0702230811i79bbc10dqd6e10ac05b06ac16@mail.gmail.com>
	<1172267591.13040.30.camel@jaalaptop>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_78929_6725060.1172356854055
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

   Thanks!

   I did indeed mean to say "devrocket" when I said "MontaVista"

   I went down the DDD/gdb  route using the MontaVista command line tools.
Their ppc_405-gdb connects to the abatron bdi2000 as a gdb server.  I was
able to get that to work to some extent.

    I did not ask my main question correctly enough.  Let me rephrase.

    My main question (for the MontaVista experts out there) is either

    1) In DevRocket, what kind of project do you choose to debug an
externally build .elf file?
       MontaVista support engineers had no clue.

    or

    2) How do you use DevRocket to create a cross compiled set of code
linked to a specific address.
       MontaVista support engineers also had no clue on this one.

   If either answer is no, OK.

    Now that I have the DDD/gdb/Abatron complex working, I don't think I
absolutely need the DevRocket and its nice (but slow) facilities.  It would
be nice to do the cross compile under DevRocket, but the Xilinx EDK is doing
just fine.

    I will look into uboot later, when I do another attempt at getting linux
into the system.

   I failed to mention that we have the system ace chip with a compact flash
card, and it is apparently functional.  It provides all the "flash" that we
need.  We do have some onboard flash for configuration data.

   Our project is simultaneously complex and simple.  It is complex in what
it does ( a complicated receiver based on latest DSL technology), but simple
in the household chores (linux is almost overkill, but we do need ethernet
and all that implies).

  Interesting we can get PPC linux into 16 meg.  Once that happens, I'll try
it again.

thanks,
wade


On 2/23/07, Jeff Angielski <jeff@theptrgroup.com> wrote:
>
> On Fri, 2007-02-23 at 10:11 -0600, Wade Maxfield wrote:
> >
> >   I want to debug a ppc custom boot loader with Montavista (since we
> > spent the money on it) under the Xilinx fx60.
>
> Writing custom bootloaders is nontrivial.  Are you sure you really want
> to do that?
>
> And what does MV have to do with the bootloader?


<snip>

--
> Jeff Angielski
> The PTR Group
>
>

------=_Part_78929_6725060.1172356854055
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp;&nbsp; Thanks!<br><br>&nbsp;&nbsp; I did indeed mean to say &quot;devrocket&quot; when I said &quot;MontaVista&quot;<br><br>&nbsp;&nbsp; I went down the DDD/gdb&nbsp; route using the MontaVista command line tools.&nbsp; Their ppc_405-gdb connects to the abatron bdi2000 as a gdb server.&nbsp; I was able to get that to work to some extent.
<br><br>&nbsp; &nbsp; I did not ask my main question correctly enough.&nbsp; Let me rephrase.<br><br>&nbsp;&nbsp;&nbsp; My main question (for the MontaVista experts out there) is either<br><br>&nbsp; &nbsp; 1) In DevRocket, what kind of project do you choose to debug an externally build .elf file?
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MontaVista support engineers had no clue.<br><br>&nbsp;&nbsp;&nbsp; or<br><br>&nbsp;&nbsp;&nbsp; 2) How do you use DevRocket to create a cross compiled set of code linked to a specific address.&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MontaVista support engineers also had no clue on this one.
<br><br>&nbsp;&nbsp; If either answer is no, OK.&nbsp; <br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; Now that I have the DDD/gdb/Abatron complex working, I don&#39;t think I absolutely need the DevRocket and its nice (but slow) facilities.&nbsp; It would be nice to do the cross compile under DevRocket, but the Xilinx EDK is doing just fine.
<br><br>&nbsp;&nbsp;&nbsp; I will look into uboot later, when I do another attempt at getting linux into the system.<br><br>&nbsp;&nbsp; I failed to mention that we have the system ace chip with a compact flash card, and it is apparently functional.&nbsp; It provides all the &quot;flash&quot; that we need.&nbsp; We do have some onboard flash for configuration data.
<br><br>&nbsp;&nbsp; Our project is simultaneously complex and simple.&nbsp; It is complex in what it does ( a complicated receiver based on latest DSL technology), but simple in the household chores (linux is almost overkill, but we do need ethernet and all that implies).
<br><br>&nbsp; Interesting we can get PPC linux into 16 meg.&nbsp; Once that happens, I&#39;ll try it again.<br><br>thanks,<br>wade<br>&nbsp;&nbsp; <br><br><div><span class="gmail_quote">On 2/23/07, <b class="gmail_sendername">Jeff Angielski
</b> &lt;<a href="mailto:jeff@theptrgroup.com">jeff@theptrgroup.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Fri, 2007-02-23 at 10:11 -0600, Wade Maxfield wrote:
<br>&gt;<br>&gt;&nbsp;&nbsp; I want to debug a ppc custom boot loader with Montavista (since we<br>&gt; spent the money on it) under the Xilinx fx60.<br><br>Writing custom bootloaders is nontrivial.&nbsp;&nbsp;Are you sure you really want<br>
to do that?<br><br>And what does MV have to do with the bootloader?</blockquote><div><br>&lt;snip&gt; <br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
--<br>Jeff Angielski<br>The PTR Group<br><br></blockquote></div><br>

------=_Part_78929_6725060.1172356854055--
