Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 2C39767BF7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 02:07:06 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1662286ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 09:07:04 -0700 (PDT)
Message-ID: <45a1b53e0608210907k6acec26ag94b0621273109532@mail.gmail.com>
Date: Mon, 21 Aug 2006 11:07:04 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: PPC beginner questions
In-Reply-To: <528646bc0608210838p4071f9eeie560fbba18ae2b3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_41813_41690.1156176424251"
References: <45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com>
	<528646bc0608210714g51928043lb729e80bda753d4d@mail.gmail.com>
	<45a1b53e0608210759p270c2f8dy694e91f409d57729@mail.gmail.com>
	<528646bc0608210838p4071f9eeie560fbba18ae2b3d@mail.gmail.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_41813_41690.1156176424251
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 OK.  I'm breaking my promise. :)  A couple more questions.

On 8/21/06, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> On 8/21/06, Wade Maxfield <wmaxfield@gmail.com> wrote:
> > Hi Grant,
> >
> >   Thanks!
> >
> >   in*
> >   out*
> >
> >   I'm assuming inb() outb(), inw() outw()??  I've been googling and have
> > come up short with info that makes sense. It is almost all x86 centric.
>
> in_8, in_be16, in_be32, out_8, out_be16, out_be32 for big-endian
> device registers
> in_8, in_le16, in_le32, out_8, out_le16, out_le32 for little endian
> device registers


-->Interesting.  Do these functions do 'eieio'  (Email, Internet, Electronic
Information Officer functions (southpark cartoon), err, or  Enforce In-Order
Execution of Input/Output) for me, or do I have to do that?  I'm still
confused as to that Old MacDonald function.


>
> >   We will not be porting these drivers, this is a captive box internal
> use
> > only, limited run (200 units or so), 10 to 20 year lifespan once it hits
> the
> > field.
> >
> >   So, the virtual address I get back can be used directly.  Can I cast
> to
> > short * and long * and char *?
>
> heh, yes you can; but if your writing new code why not use good
> practice from the start?  :)


--> Ok, you win.  How about ioread8() or inb() also?  Are they not coded in
PPC correctly? Or is the in_8() more modern?


>
> >    I apologize for the basic questions, but I expect this will be a
> final
> > question for quite some time.
>
> No worries; ask away!



--> is ioremap() equivalent to ioremap_nocache() on the PPC 405?


THANKS AGAIN!!!!
wade :)

Cheers,
> g.
>
>
> BTW, when on the mailing list, please use "reply to all" and put your
> comments below what you're commenting on.  This keeps the thread on
> the mailing list for others to see, and it makes it blatentely obvious
> what you're commenting on.  (just general list-etiquette)
>
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>

------=_Part_41813_41690.1156176424251
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp;OK.&nbsp; I'm breaking my promise. :)&nbsp; A couple more questions.<br><br><div><span class="gmail_quote">On 8/21/06, <b class="gmail_sendername">Grant Likely</b> &lt;<a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On 8/21/06, Wade Maxfield &lt;<a href="mailto:wmaxfield@gmail.com">wmaxfield@gmail.com
</a>&gt; wrote:<br>&gt; Hi Grant,<br>&gt;<br>&gt;&nbsp;&nbsp; Thanks!<br>&gt;<br>&gt;&nbsp;&nbsp; in*<br>&gt;&nbsp;&nbsp; out*<br>&gt;<br>&gt;&nbsp;&nbsp; I'm assuming inb() outb(), inw() outw()??&nbsp;&nbsp;I've been googling and have<br>&gt; come up short with info that makes sense. It is almost all x86 centric.
<br><br>in_8, in_be16, in_be32, out_8, out_be16, out_be32 for big-endian<br>device registers<br>in_8, in_le16, in_le32, out_8, out_le16, out_le32 for little endian<br>device registers</blockquote><div><br>--&gt;Interesting.&nbsp; Do these functions do 'eieio'&nbsp; (Email, Internet, Electronic Information Officer functions (southpark cartoon), err, or&nbsp; Enforce In-Order Execution of Input/Output) for me, or do I have to do that?&nbsp; I'm still confused as to that Old MacDonald function.
<br><br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br>&gt;&nbsp;&nbsp; We will not be porting these drivers, this is a captive box internal use
<br>&gt; only, limited run (200 units or so), 10 to 20 year lifespan once it hits the<br>&gt; field.<br>&gt;<br>&gt;&nbsp;&nbsp; So, the virtual address I get back can be used directly.&nbsp;&nbsp;Can I cast to<br>&gt; short * and long * and char *?
<br><br>heh, yes you can; but if your writing new code why not use good<br>practice from the start?&nbsp;&nbsp;:)</blockquote><div><br>--&gt; Ok, you win.&nbsp; How about ioread8() or inb() also?&nbsp; Are they not coded in PPC correctly? Or is the in_8() more modern?
<br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;I apologize for the basic questions, but I expect this will be a final
<br>&gt; question for quite some time.<br><br>No worries; ask away!</blockquote><div><br><br>--&gt; is ioremap() equivalent to ioremap_nocache() on the PPC 405?<br><br><br>THANKS AGAIN!!!!<br>wade :) <br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Cheers,<br>g.<br><br><br>BTW, when on the mailing list, please use &quot;reply to all&quot; and put your<br>comments below what you're commenting on.&nbsp;&nbsp;This keeps the thread on<br>the mailing list for others to see, and it makes it blatentely obvious
<br>what you're commenting on.&nbsp;&nbsp;(just general list-etiquette)<br><br>--<br>Grant Likely, B.Sc. P.Eng.<br>Secret Lab Technologies Ltd.<br><a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a><br>(403) 399-0195
<br></blockquote></div><br>

------=_Part_41813_41690.1156176424251--
