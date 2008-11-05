Return-Path: <minhtuanmt1@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by ozlabs.org (Postfix) with ESMTP id 29E4ADDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Nov 2008 20:11:06 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3474151rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 05 Nov 2008 01:11:04 -0800 (PST)
Message-ID: <9a53cf970811050111s580b684cu2df28e51547feb35@mail.gmail.com>
Date: Wed, 5 Nov 2008 16:11:04 +0700
From: "Minh Tuan Duong" <minhtuanmt1@gmail.com>
To: "Ayman El-Khashab" <AymanE@tanisys.com>
Subject: Re: LSISAS3041E-R PCIe card bring up failed on AMCC Canyonlands
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F855@tanisys-ex2.Tanisys.Local>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_961_23298991.1225876264556"
References: <9a53cf970811021916w57a91188ma126591932b78feb@mail.gmail.com>
	<16691A8B34B5D9458EA3A1C37A11555A0137F84E@tanisys-ex2.Tanisys.Local>
	<9a53cf970811032218j6f4817b8vf3f3197e81535f88@mail.gmail.com>
	<16691A8B34B5D9458EA3A1C37A11555A0137F855@tanisys-ex2.Tanisys.Local>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_961_23298991.1225876264556
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Ayman! I am checking the issue.

On Tue, Nov 4, 2008 at 10:49 PM, Ayman El-Khashab <AymanE@tanisys.com>wrote:

> Minh Tuan Duong <mailto:minhtuanmt1@gmail.com> said on Tuesday, November
> 04, 2008 12:18 AM:
>
> > Thanks Ayman.
> > I applied the patch but it's still no progress. Do you have any
> > suggestion?
>
> I looked back at the log and it seems that the PCIE device link was ok.
> That seems odd that it would not work later unless for some reason it
> was disabled.  So a few things you could try a) verify that the board
> you are using works in a PC w/linux for instance.  b) Try to load the
> driver for the electronics (for instance, the particular flavor of SATA
> controller).
>
> Secondly, have you tried a recent kernel + device tree?
>
>


-- 
Best regards,
Tuan

------=_Part_961_23298991.1225876264556
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Ayman! I am checking the issue.<br><br><div class="gmail_quote">On Tue, Nov 4, 2008 at 10:49 PM, Ayman El-Khashab <span dir="ltr">&lt;<a href="mailto:AymanE@tanisys.com">AymanE@tanisys.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Minh Tuan Duong &lt;mailto:<a href="mailto:minhtuanmt1@gmail.com">minhtuanmt1@gmail.com</a>&gt; said on Tuesday, November<br>
04, 2008 12:18 AM:<br>
<div class="Ih2E3d"><br>
&gt; Thanks Ayman.<br>
&gt; I applied the patch but it&#39;s still no progress. Do you have any<br>
&gt; suggestion?<br>
<br>
</div>I looked back at the log and it seems that the PCIE device link was ok.<br>
That seems odd that it would not work later unless for some reason it<br>
was disabled. &nbsp;So a few things you could try a) verify that the board<br>
you are using works in a PC w/linux for instance. &nbsp;b) Try to load the<br>
driver for the electronics (for instance, the particular flavor of SATA<br>
controller).<br>
<br>
Secondly, have you tried a recent kernel + device tree?<br>
<br>
</blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Tuan<br>

------=_Part_961_23298991.1225876264556--
