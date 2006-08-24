Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id E0C1767D7A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 03:58:00 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so569665ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 10:57:55 -0700 (PDT)
Message-ID: <45a1b53e0608241057j4ebe519drd1e431a2275ccdde@mail.gmail.com>
Date: Thu, 24 Aug 2006 12:57:55 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: "Peter Ryser" <peter.ryser@xilinx.com>, ppc <linuxppc-embedded@ozlabs.org>
Subject: Re: MontaVista 2.6 Kernel support for Xilinx ML40x
In-Reply-To: <44EDD947.3000105@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_130509_28544486.1156442275630"
References: <DADA32856852FC458E0F96B664A6F55E011E2423@kom-mailsrv1.kontron-modular.com>
	<45a1b53e0608240836l52ed51b5u309e31dd8486cc5b@mail.gmail.com>
	<44EDD947.3000105@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_130509_28544486.1156442275630
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good question.  How long before lockup?  The only core that should be
licensed is the ethernet, and I know it was sysgened on a system with a
license.  This is the Xilinx reference design for the ml403 board.


On 8/24/06, Peter Ryser <peter.ryser@xilinx.com> wrote:
>
>  Wade,
>
> are you sure that you did not build your hardware with evaluation cores of
> the licenses? If you are using the evaluation licenses the hardware (FPGA
> design) will stop working after a certain amount of time and you will see a
> lock-up.
>
> - Peter
>
>
> Wade Maxfield wrote:
>
>
>   I've got the LSP, and have booted it on the ML40X.
>
>   In my opinion it is currently unstable, but that is my opinion.  I've
> not been able to keep it powered up for 24 hours without it locking up on
> the RS232 serial terminal.  Also, running updatedb over nfs causes it to
> abort with a kernel panic, although that might be an interraction with the
> nfs server.  (Although even if the nfs server dies (which it did not), I
> don't expect a kernel panic).
>
>    I have had it run over 6 hours without issue, so I expect subtle memory
> leaks, not serious problems.
>
>
>
> On 8/24/06, Claus Gindhart < claus.gindhart@kontron.com> wrote:
> >
> > Frank,
> >
> > due to my understanding of the GPL (and i have already invested some
> > time
> > in understanding the various flavours of open source licences), you
> > should
> > contact Montavista, and ask them for the sources.
> >
> > This board adaption is derivative work of the GPL Kernel, so the result
> > of
> > this work also falls under the GPL, and has to be made freely available
> > under the terms of the GPL.
> >
> > --
> > Mit freundlichen Gruessen / Best regards
> >
> > Claus Gindhart
> > SW R&D
> > Kontron Modular Computers
> > phone :++49 (0)8341-803-374
> > mailto:claus.gindhart@kontron-modular.com
> > http://www.kontron.com
> >
> > -----BEGIN GEEK CODE BLOCK-----
> >   Version: 3.1
> >   GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
> >   K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
> >   D-- G e++> h--- !r x+++
> > ------END GEEK CODE BLOCK------
> >
> >
> > -----Original Message-----
> > From: linuxppc-embedded-bounces+claus.gindhart=kontron.com@ozlabs.org
> > [mailto: linuxppc-embedded-bounces+claus.gindhart=kontron.com@ozlabs.org
> > ]
> > On Behalf Of Frank D Lombardo
> > Sent: Donnerstag, 24. August 2006 15:59
> > To: linuxppc-embedded@ozlabs.org
> > Subject: MontaVista 2.6 Kernel support for Xilinx ML40x
> >
> >
> > I noticed that MontaVista now has their Pro 4.0 version (2.6 Kernel)
> > available for the Xilinx ML40x series of boards.  I would assume that
> > means driver support for at least most of the hardware on the boards.
> > Is this code that should be freely available?  How would one get a copy
> > of these drivers?  I am interested in drivers for the ML403.
> >
> > Thanks,
> > Frank
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
> ------------------------------
>
> _______________________________________________ Linuxppc-embedded mailing
> list Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_130509_28544486.1156442275630
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good question.&nbsp; How long before lockup?&nbsp; The only core that should be licensed is the ethernet, and I know it was sysgened on a system with a license.&nbsp; This is the Xilinx reference design for the ml403 board.<br><br><br><div>
<span class="gmail_quote">On 8/24/06, <b class="gmail_sendername">Peter Ryser</b> &lt;<a href="mailto:peter.ryser@xilinx.com">peter.ryser@xilinx.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>


  
  

<div bgcolor="#ffffff" text="#000000">
Wade,<br>
<br>
are you sure that you did not build your hardware with evaluation cores
of the licenses? If you are using the evaluation licenses the hardware
(FPGA design) will stop working after a certain amount of time and you
will see a lock-up.<br>
<br>
- Peter<br>
<br>
<br>
Wade Maxfield wrote:<br>
<blockquote cite="http://mid45a1b53e0608240836l52ed51b5u309e31dd8486cc5b@mail.gmail.com" type="cite"></blockquote></div><div><span class="e" id="q_10d41196a402325c_1"><br>
&nbsp; I've got the LSP, and have booted it on the ML40X.<br>
&nbsp;<br>
&nbsp; In my opinion it is currently unstable, but that is my opinion.&nbsp; I've
not been able to keep it powered up for 24 hours without it locking up
on the RS232 serial terminal.&nbsp; Also, running updatedb over nfs causes
it to abort with a kernel panic, although that might be an interraction
with the nfs server.&nbsp; (Although even if the nfs server dies (which it
did not), I don't expect a kernel panic).
  <br>
  <br>
&nbsp;&nbsp; I have had it run over 6 hours without issue, so I expect subtle
memory leaks, not serious problems.<br>
  <br>
  <br>
  <br>
  <div><span class="gmail_quote">On 8/24/06, <b class="gmail_sendername">Claus Gindhart</b> &lt;
  <a href="mailto:claus.gindhart@kontron.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">claus.gindhart@kontron.com</a>&gt;
wrote:</span>
  <blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Frank,<br>
    <br>
due to my understanding of the GPL (and i have already invested some
time<br>
in understanding the various flavours of open source licences), you
should<br>
contact Montavista, and ask them for the sources.<br>
    <br>
This board adaption is derivative work of the GPL Kernel, so the result
of<br>
this work also falls under the GPL, and has to be made freely available<br>
under the terms of the GPL.<br>
    <br>
--<br>
Mit freundlichen Gruessen / Best regards
    <br>
    <br>
Claus Gindhart<br>
SW R&amp;D<br>
Kontron Modular Computers<br>
phone :++49 (0)8341-803-374<br>
mailto:<a href="mailto:claus.gindhart@kontron-modular.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">claus.gindhart@kontron-modular.com</a><br>
    <a href="http://www.kontron.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.kontron.com</a><br>
    <br>
-----BEGIN GEEK CODE BLOCK-----<br>
&nbsp;&nbsp;Version: 3.1<br>
&nbsp;&nbsp;GU d- s++:&gt;++:+ a+ C++$ !U !P L++&gt;$ E-- W+(-) N- o?<br>
&nbsp;&nbsp;K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++<br>
&nbsp;&nbsp;D-- G e++&gt; h--- !r x+++
    <br>
------END GEEK CODE BLOCK------<br>
    <br>
    <br>
-----Original Message-----<br>
From: linuxppc-embedded-bounces+claus.gindhart=<a href="mailto:kontron.com@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">kontron.com@ozlabs.org</a><br>
[mailto:<a href="mailto:linuxppc-embedded-bounces+claus.gindhart=kontron.com@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
linuxppc-embedded-bounces+claus.gindhart=kontron.com@ozlabs.org</a>]<br>
On Behalf Of Frank D Lombardo<br>
Sent: Donnerstag, 24. August 2006 15:59<br>
To: <a href="mailto:linuxppc-embedded@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">linuxppc-embedded@ozlabs.org
    </a><br>
Subject: MontaVista 2.6 Kernel support for Xilinx ML40x<br>
    <br>
    <br>
I noticed that MontaVista now has their Pro 4.0 version (2.6 Kernel)<br>
available for the Xilinx ML40x series of boards.&nbsp;&nbsp;I would assume that<br>
means driver support for at least most of the hardware on the boards.
    <br>
Is this code that should be freely available?&nbsp;&nbsp;How would one get a copy<br>
of these drivers?&nbsp;&nbsp;I am interested in drivers for the ML403.<br>
    <br>
Thanks,<br>
Frank<br>
_______________________________________________<br>
Linuxppc-embedded mailing list
    <br>
    <a href="mailto:Linuxppc-embedded@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Linuxppc-embedded@ozlabs.org</a><br>
    <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
_______________________________________________
    <br>
Linuxppc-embedded mailing list<br>
    <a href="mailto:Linuxppc-embedded@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Linuxppc-embedded@ozlabs.org</a><br>
    <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://ozlabs.org/mailman/listinfo/linuxppc-embedded
    </a><br>
  </blockquote>
  </div>
  <br>
  </span></div><div><pre><hr size="4" width="90%"></pre></div><div><span class="q">
_______________________________________________
Linuxppc-embedded mailing list
<a href="mailto:Linuxppc-embedded@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Linuxppc-embedded@ozlabs.org</a>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></span></div><div>

</div>


</div></blockquote></div><br>

------=_Part_130509_28544486.1156442275630--
