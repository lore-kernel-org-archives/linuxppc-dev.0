Return-Path: <sujababuraj@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by ozlabs.org (Postfix) with ESMTP id ACF43DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 22:22:10 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so4474279rvf.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 04 Jan 2008 03:22:09 -0800 (PST)
Message-ID: <a3b98ac10801040322p236e9467xc61c4e8dc03532ef@mail.gmail.com>
Date: Fri, 4 Jan 2008 16:52:09 +0530
From: "suja Baburaj" <sujababuraj@gmail.com>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: MPC8260ADS and linux-2.6
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D1682A@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15307_23750534.1199445729544"
References: <a3b98ac10801022105w240b0f96race4d3aa84e51f27@mail.gmail.com>
	<477D2255.3040803@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D1682A@ismail.innsys.innovsys.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_15307_23750534.1199445729544
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
The PQ2FADS support worked for MPC8260ADS.
Thanks to Rune and scott for the input.
-suja



> >
> > suja Baburaj wrote:
> > > I have an MPC8260ADS board with (eldk)linux-2.4.25 working
> > fine on it.
> > > Now i want to try linux-2.6.X on the board.
> >
> > There's no support for that specific board in mainstream 2.6
> > yet, but it
> > should be fairly simple to get it working using the
> > mpc8272ads support
> > as an example.
>
> There is support, but it is in arch/ppc not arch/powerpc
> (PQ2FADS support works for this board in arch/ppc)
>

------=_Part_15307_23750534.1199445729544
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>The PQ2FADS support worked for MPC8260ADS.<br>Thanks to Rune and scott for the input.<br>-suja<br><br><br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><div><div></div><div class="Wj3C7c">&gt;<br>&gt; suja Baburaj wrote:<br>&gt; &gt; I have an MPC8260ADS board with (eldk)linux-2.4.25 working<br>&gt; fine on it.<br>&gt; &gt; Now i want to try linux-2.6.X on the board.
<br>&gt;<br>&gt; There&#39;s no support for that specific board in mainstream 2.6<br>&gt; yet, but it<br>&gt; should be fairly simple to get it working using the<br>&gt; mpc8272ads support<br>&gt; as an example.<br><br></div>
</div>There is support, but it is in arch/ppc not arch/powerpc<br>(PQ2FADS support works for this board in arch/ppc)<br></blockquote></div><br>

------=_Part_15307_23750534.1199445729544--
