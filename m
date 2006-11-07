Return-Path: <luong.ngo@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.199])
	by ozlabs.org (Postfix) with ESMTP id 6576C67DA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 10:37:30 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id z31so1088798nzd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 07 Nov 2006 15:37:28 -0800 (PST)
Message-ID: <1b2aacd80611071530y3238b6fha6cf6869ecf211fc@mail.gmail.com>
Date: Tue, 7 Nov 2006 15:30:19 -0800
From: "Luong Ngo" <luong.ngo@gmail.com>
To: "Andy Fleming" <afleming@freescale.com>
Subject: Re: ethernet interface problem with kernel 2.6.14 on MPC8343E
In-Reply-To: <2E3AE2D7-49C3-40BB-B939-7FE821EA8C2A@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15037_27699096.1162942219297"
References: <1b2aacd80611061551t78cc4f1aoef66377e82c2daed@mail.gmail.com>
	<2E3AE2D7-49C3-40BB-B939-7FE821EA8C2A@freescale.com>
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

------=_Part_15037_27699096.1162942219297
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

It is working now. Thanks for the help. I am just curious that linux kernel
does not know 1 interface's connection is down and check the other interface
to see if it can reaches the destination with other interfaces?

Thanks,
l.ngo

On 11/7/06, Andy Fleming <afleming@freescale.com> wrote:
>
>
> On Nov 6, 2006, at 17:51, Luong Ngo wrote:
>
> > Hello,
> >
> > I am having a problem with the interfaces eth0 and eth1 when
> > running 2.6.14 kernel on a board with MPC8343E. The problem I
> > encounters is only one of the eth interface is really working. Only
> > the one that is configured first, using "ifconfig eth[0/1]
> > 192.168.1.1 netmask 255.255.255.0" can ping and be pinged from
> > another host. I wonder if there is setup difference between the
> > TSEC1 and TSEC2 or this is not related to hardware but rather
> > something in the kernel. When I ping from other host, from within
> > the Gianfar driver, I can see the packet is received on both
> > interfaces but only one responds. When pinging from the system
> > itself, only the working interface sending out packet, the other
> > interface does not send anything. Please advise me what I am doing
> > wrong or missing.
> >
>
> It sounds like both work for you, but not at the same time?
>
> If you set them both to the same IP address, it won't work.
> Actually, it won't work if you set them to different IP addresses on
> the same subnet (as defined by their netmasks).
>
> I think you are trying to get Linux to do something that it doesn't
> do.  Try setting them to different IP addresses, like 192.168.1.1 and
> 192.168.2.1
>
> Andy
>

------=_Part_15037_27699096.1162942219297
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>It is working now. Thanks for the help. I am just curious that linux kernel does not know 1 interface's connection is down and check the other interface to see if it can reaches the destination with other interfaces?
<br><br>Thanks,<br>l.ngo<br><br><div><span class="gmail_quote">On 11/7/06, <b class="gmail_sendername">Andy Fleming</b> &lt;<a href="mailto:afleming@freescale.com">afleming@freescale.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>On Nov 6, 2006, at 17:51, Luong Ngo wrote:<br><br>&gt; Hello,<br>&gt;<br>&gt; I am having a problem with the interfaces eth0 and eth1 when<br>&gt; running 2.6.14 kernel on a board with MPC8343E. The problem I<br>&gt; encounters is only one of the eth interface is really working. Only
<br>&gt; the one that is configured first, using &quot;ifconfig eth[0/1]<br>&gt; <a href="http://192.168.1.1">192.168.1.1</a> netmask <a href="http://255.255.255.0">255.255.255.0</a>&quot; can ping and be pinged from<br>&gt; another host. I wonder if there is setup difference between the
<br>&gt; TSEC1 and TSEC2 or this is not related to hardware but rather<br>&gt; something in the kernel. When I ping from other host, from within<br>&gt; the Gianfar driver, I can see the packet is received on both<br>&gt; interfaces but only one responds. When pinging from the system
<br>&gt; itself, only the working interface sending out packet, the other<br>&gt; interface does not send anything. Please advise me what I am doing<br>&gt; wrong or missing.<br>&gt;<br><br>It sounds like both work for you, but not at the same time?
<br><br>If you set them both to the same IP address, it won't work.<br>Actually, it won't work if you set them to different IP addresses on<br>the same subnet (as defined by their netmasks).<br><br>I think you are trying to get Linux to do something that it doesn't
<br>do.&nbsp;&nbsp;Try setting them to different IP addresses, like <a href="http://192.168.1.1">192.168.1.1</a> and<br><a href="http://192.168.2.1">192.168.2.1</a><br><br>Andy<br></blockquote></div><br>

------=_Part_15037_27699096.1162942219297--
