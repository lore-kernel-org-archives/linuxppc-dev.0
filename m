Return-Path: <jcrigby@gmail.com>
Message-ID: <4b73d43f0603300839k4465b2aao7e073f83052b97ff@mail.gmail.com>
Date: Thu, 30 Mar 2006 09:39:37 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel for MPC Lite 5200 will not compile
In-Reply-To: <4b73d43f0603300829q7d45a029qdb5d8006ccda7275@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11864_31465819.1143736777029"
References: <442B11E8.7020107@246tNt.com>
	<20060330003419.3FF71353A37@atlas.denx.de>
	<4b73d43f0603300829q7d45a029qdb5d8006ccda7275@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_11864_31465819.1143736777029
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

After thinking about this more....I don't want to push getting the official
Freescale code into the tree.  If Dale's code works as well as the Freescal=
e
code then lets stay with it because it is a lot cleaner.  The effort of
porting other drivers will hopefully be easier now that I have the
experience of having done ATA.

On 3/30/06, John Rigby <jcrigby@gmail.com> wrote:
>
> Sent this to Wolfgang last night.  Accidently omitted Syvain and the list=
.
>
>
> The actual bestcomm "microcode" in Sylvain's tree is the same as the
> latest Freescale supported code.  The linux driver code that interfaces w=
ith
> it is code written by Dale Farnsworth and has Montavista copyright.  I do=
n't
> know if it is based on old Freescale (Motorola) code or if it is Dale's
> creation (perhaps Dale can comment).
>
> I have just spent some time getting UDMA support into the ATA driver usin=
g
> the the bestcomm code in Sylvain's tree.  In the process I found some bug=
s
> in the code that may explain some problems people have seen with the FEC
> driver.  I'll try to get the patch out tomorrow.
>
> The ATA driver is a port from a version that worked on an older kernel an=
d
> used the supported Freescale Bestcomm code.  I did the port because it wa=
s
> my understanding that attempts to get the supported Freescale code into a
> public tree had met with resistance in the past.  (Second hand info, I'm
> actually fairly new to the 52xx world).
>
> The pluses for the Freescale version is that several devices are supporte=
d
> that are not in Sylvain's tree.  The version in Sylvain's kernel has a
> generic api plus specific code for FEC.  My upcoming patch fixes some bug=
s,
> adds some missing functionality that I need for ATA and adds the specific
> ATA dma driver code.
>
> The biggest minus for the Freescale version is that it is really opaque.
> Its implementation makes it hard to figure out what the code is actually
> doing.
>
> If there is a chance of getting the Freescale Bestcomm code into Sylvain'=
s
> tree (and on up the line to Linus) I would welcome that since I would not
> have to port other Bestcomm dependent drivers to the version in Sylvain's
> tree.  I would gladly port the current FEC code to the Freescale Bestcomm
> code to avoid the work of porting the other drivers.  Also we at Freescal=
e
> would prefer to have one version of the Bestcomm code circulating.
>
> So I guess my question for those with an opinion is what version of
> Bestcomm should be we use for 5200.
>
> Thanks for your input
> John
>
> On 3/29/06, Wolfgang Denk <wd@denx.de> wrote:
>
> > In message < 442B11E8.7020107@246tNt.com> you wrote:
> > >
> > > It is ?
> >
> > I think so.
> >
> > > I don't know about the 2.6-denx, but the stock 2.6.15 should work jus=
t
> > fine.
> > > What's wrong with it ? (except it misses some drivers ... it should
> > compile
> > > and boot just fine)
> >
> > Isn't the current reengineered implementation of  the  BestComm  code
> > based  on  an very old Freescale version, which has known limitations
> > and problems?
> >
> > Or has there any action resulted  out  of  the  discussion  with  the
> > Freescale engineers, and I have missed it?
> >
> > Best regards,
> >
> > Wolfgang Denk
> >
> > --
> > Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> > Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> > In accord with UNIX philosophy, Perl gives you enough  rope  to  hang
> > yourself.              - L. Wall & R. L. Schwartz, _Programming Perl_
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
>

------=_Part_11864_31465819.1143736777029
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

After thinking about this more....I don't want to push getting the official=
 Freescale code into the tree.&nbsp; If Dale's code works as well as the Fr=
eescale code then lets stay with it because it is a lot cleaner.&nbsp; The =
effort of porting other drivers will hopefully be easier now that I have th=
e experience of having done ATA.
<br><br><div><span class=3D"gmail_quote">On 3/30/06, <b class=3D"gmail_send=
ername">John Rigby</b> &lt;<a href=3D"mailto:jcrigby@gmail.com">jcrigby@gma=
il.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">
<div style=3D"direction: ltr;">Sent this to Wolfgang last night.&nbsp; Acci=
dently omitted Syvain and the list.</div><div style=3D"direction: ltr;"><sp=
an class=3D"q"><br><br>The actual bestcomm &quot;microcode&quot; in Sylvain=
's tree is the same as the
latest Freescale supported code.&nbsp; The linux driver code that interface=
s
with it is code written by Dale Farnsworth and has Montavista
copyright.&nbsp; I don't know if it is based on old Freescale (Motorola)
code or if it is Dale's creation (perhaps Dale can comment).
<br><br>I have just spent some time getting UDMA support into the ATA
driver using the the bestcomm code in Sylvain's tree.&nbsp; In the process =
I
found some bugs in the code that may explain some problems people have
seen with the FEC driver.&nbsp; I'll try to get the patch out tomorrow.
<br><br>The ATA driver is a port from a version that worked on an
older kernel and used the supported Freescale Bestcomm code.&nbsp; I did th=
e
port because it was my understanding that attempts to get the supported
Freescale code into a public tree had met with resistance in the past.&nbsp=
;
(Second hand info, I'm actually fairly new to the 52xx world).
<br><br>The pluses for the Freescale version is that several devices
are supported that are not in Sylvain's tree.&nbsp; The version in Sylvain'=
s
kernel has a generic api plus specific code for FEC.&nbsp; My upcoming patc=
h
fixes some bugs, adds some missing functionality that I need for ATA
and adds the specific ATA dma driver code.
<br><br>The biggest minus for the Freescale version is that it is
really opaque.&nbsp; Its implementation makes it hard to figure out what th=
e
code is actually doing.<br><br>If there is a chance of getting the
Freescale Bestcomm code into Sylvain's tree (and on up the line to
Linus) I would welcome that since I would not have to port other
Bestcomm dependent drivers to the version in Sylvain's tree.&nbsp; I would
gladly port the current FEC code to the Freescale Bestcomm code to
avoid the work of porting the other drivers.&nbsp; Also we at Freescale
would prefer to have one version of the Bestcomm code circulating.
<br><br>So I guess my question for those with an opinion is what version of=
 Bestcomm should be we use for 5200.<br><br>Thanks for your input<br>John<b=
r><br></span></div><div style=3D"direction: ltr;"><div></div><div style=3D"=
direction: ltr;">
<span class=3D"q"><span class=3D"gmail_quote">On 3/29/06, <b class=3D"gmail=
_sendername">
Wolfgang Denk</b> &lt;<a href=3D"mailto:wd@denx.de" target=3D"_blank" oncli=
ck=3D"return top.js.OpenExtLink(window,event,this)">wd@denx.de</a>&gt; wrot=
e:</span></span></div><div style=3D"direction: ltr;"><span class=3D"e" id=
=3D"q_10a4bfd5d91d2bf4_4">
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">In message &lt;
<a href=3D"mailto:442B11E8.7020107@246tNt.com" target=3D"_blank" onclick=3D=
"return top.js.OpenExtLink(window,event,this)">442B11E8.7020107@246tNt.com<=
/a>&gt; you wrote:<br>&gt;<br>&gt; It is ?<br><br>I think so.<br><br>&gt; I=
 don't know about the=20
2.6-denx, but the stock 2.6.15 should work just fine.
<br>&gt; What's wrong with it ? (except it misses some drivers ... it shoul=
d compile<br>&gt; and boot just fine)<br><br>Isn't the current reengineered=
 implementation of&nbsp;&nbsp;the&nbsp;&nbsp;BestComm&nbsp;&nbsp;code<br>ba=
sed&nbsp;&nbsp;on&nbsp;&nbsp;an very old Freescale version, which has known=
 limitations
<br>and problems?<br><br>Or has there any action resulted&nbsp;&nbsp;out&nb=
sp;&nbsp;of&nbsp;&nbsp;the&nbsp;&nbsp;discussion&nbsp;&nbsp;with&nbsp;&nbsp=
;the<br>Freescale engineers, and I have missed it?<br><br>Best regards,<br>=
<br>Wolfgang Denk<br><br>--<br>Software Engineering:&nbsp;&nbsp;Embedded an=
d Realtime Systems,&nbsp;&nbsp;Embedded Linux
<br>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: <a href=3D"m=
ailto:wd@denx.de" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(wi=
ndow,event,this)">wd@denx.de</a><br>In accord with UNIX philosophy, Perl gi=
ves you enough&nbsp;&nbsp;rope&nbsp;&nbsp;to&nbsp;&nbsp;hang
<br>yourself.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;- L. Wall &amp; R. L. Schwartz, _Programming Perl_
<br>_______________________________________________<br>Linuxppc-embedded ma=
iling list<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org" target=3D"_bl=
ank" onclick=3D"return top.js.OpenExtLink(window,event,this)">Linuxppc-embe=
dded@ozlabs.org
</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded" t=
arget=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote><=
/span></div><div style=3D"direction: ltr;"></div><br>

</div></blockquote></div><br>

------=_Part_11864_31465819.1143736777029--
