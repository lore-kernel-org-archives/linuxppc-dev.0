Return-Path: <minhtuanmt1@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 942DADDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 17:18:06 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so3288168wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Nov 2008 22:18:03 -0800 (PST)
Message-ID: <9a53cf970811032218j6f4817b8vf3f3197e81535f88@mail.gmail.com>
Date: Tue, 4 Nov 2008 13:18:03 +0700
From: "Minh Tuan Duong" <minhtuanmt1@gmail.com>
To: "Ayman El-Khashab" <AymanE@tanisys.com>
Subject: Re: LSISAS3041E-R PCIe card bring up failed on AMCC Canyonlands
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F84E@tanisys-ex2.Tanisys.Local>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_64286_3907105.1225779483690"
References: <9a53cf970811021916w57a91188ma126591932b78feb@mail.gmail.com>
	<16691A8B34B5D9458EA3A1C37A11555A0137F84E@tanisys-ex2.Tanisys.Local>
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

------=_Part_64286_3907105.1225779483690
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Ayman.
I applied the patch but it's still no progress. Do you have any suggestion?

Thanks and best regards,
Tuan

On Mon, Nov 3, 2008 at 10:49 PM, Ayman El-Khashab <AymanE@tanisys.com>wrote:

> Minh Tuan Duong <> said on Sunday, November 02, 2008 9:17 PM:
>
> > I am having some problems with AMCC Canyonlands' PCIe. I've tried to
> > bring up LSISAS3041E-R PCIe card with Canyonlands but failed. It
> > seems PCIe card can be detected in U-boot but Linux (kernel
> > linux-2.6-denx). I also followed advice at
> > http://marc.info/?l=linux-netdev&m=121602350226912&w=2 applying
> > kernel 2.6.26 from kernel.org but nothing is progress. Log file is
> > attached. Please let me know if you have any idea.
>
> Looking at your log file it appears that your device has a host bridge
> on it.  Recently we had the same problem and some patches have just
> been put in for handling PCI-E secondary busses.  You will have to
> either
> put the patches in or pull a recent tree.  The exact details and patch
> are
> on linuxppc-dev, subject "Workaround invalid P2P bridge bus numbers".
> I've
> confirmed that it does function on the Canyonlands using a couple of
> different devices.
>
> Best Regards,
> Ayman
>

------=_Part_64286_3907105.1225779483690
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Ayman. <br>I applied the patch but it&#39;s still no progress. Do you have any suggestion?<br><br>Thanks and best regards,<br>Tuan<br><br><div class="gmail_quote">On Mon, Nov 3, 2008 at 10:49 PM, Ayman El-Khashab <span dir="ltr">&lt;<a href="mailto:AymanE@tanisys.com">AymanE@tanisys.com</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Minh Tuan Duong &lt;&gt; said on Sunday, November 02, 2008 9:17 PM:<br>
<div class="Ih2E3d"><br>
&gt; I am having some problems with AMCC Canyonlands&#39; PCIe. I&#39;ve tried to<br>
&gt; bring up LSISAS3041E-R PCIe card with Canyonlands but failed. It<br>
&gt; seems PCIe card can be detected in U-boot but Linux (kernel<br>
&gt; linux-2.6-denx). I also followed advice at<br>
&gt; <a href="http://marc.info/?l=linux-netdev&amp;m=121602350226912&amp;w=2" target="_blank">http://marc.info/?l=linux-netdev&amp;m=121602350226912&amp;w=2</a> applying<br>
&gt; kernel 2.6.26 from <a href="http://kernel.org" target="_blank">kernel.org</a> but nothing is progress. Log file is<br>
&gt; attached. Please let me know if you have any idea.<br>
<br>
</div>Looking at your log file it appears that your device has a host bridge<br>
on it. &nbsp;Recently we had the same problem and some patches have just<br>
been put in for handling PCI-E secondary busses. &nbsp;You will have to<br>
either<br>
put the patches in or pull a recent tree. &nbsp;The exact details and patch<br>
are<br>
on linuxppc-dev, subject &quot;Workaround invalid P2P bridge bus numbers&quot;.<br>
I&#39;ve<br>
confirmed that it does function on the Canyonlands using a couple of<br>
different devices.<br>
<br>
Best Regards,<br>
<font color="#888888">Ayman<br>
</font></blockquote></div>

------=_Part_64286_3907105.1225779483690--
