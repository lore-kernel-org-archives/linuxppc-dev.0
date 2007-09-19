Return-Path: <jeynergilcaga@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by ozlabs.org (Postfix) with ESMTP id 1128CDDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 01:35:27 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so193838rvf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 08:35:27 -0700 (PDT)
Message-ID: <cad107560709190835t5067c23fv52d5e97d39f6f69d@mail.gmail.com>
Date: Wed, 19 Sep 2007 23:35:27 +0800
From: "Jeyner Gil Caga" <jeynergilcaga@gmail.com>
To: "- Reyneke" <reynekejunk@hotmail.com>
Subject: Re: Eth1 init and link status
In-Reply-To: <BAY101-F3306F36C70FAA4D450C466BEB90@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10907_2724332.1190216127038"
References: <BAY101-F3306F36C70FAA4D450C466BEB90@phx.gbl>
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

------=_Part_10907_2724332.1190216127038
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In you statement, initialise correctly (i.e. receive and transmit), did you
use like ping or ftp to do it?

What do you mean by the word initialise?
Are you saying that after Linux has completely booted up:
1. you have one computer pinging to eth0 and you can ping eth0?
2. if eth0 is connected to the network, you use the same computer to ping
eth1 and you can ping eth1?
3. while you are pinging eth1 and you disconnect eth0 from the network,you
can not ping eth1?

On 9/19/07, - Reyneke <reynekejunk@hotmail.com> wrote:
>
> HI,
>
> We've run into a bit of an odd problem and we are not sure where to go and
> look for the cause.
>
> We have some 440EPx based hardware with two GIG-Ethernet ports using RGMII
> and 2x ET1011C PHY's. Problem is that eth1 will only initialise correctly
> (i.e. receive and transmit) if eth0 has a link. Eth0 always work OK,
> regardless of eth1 status. Eth1 will work OK if eth0 has a link (i.e.
> initialised) at time of setup. Once initialised, eth0 status is
> irrelevant.
> All this is during Linux boot process.
>
> Any ideas?
>
> We can access PHY registers via u-boot (mii commands). Same 1Gig link
> speed
> is used on both ports. Linux kernel is 2.6.19.
>
> Regards
>   Jan Reyneke
>
> _________________________________________________________________
> Can you see your house from the sky? Try Live Search Maps
> http://maps.live.com
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_10907_2724332.1190216127038
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>In you statement, initialise correctly (i.e. receive and transmit), did you use like ping or ftp to do it?<br>&nbsp;</div>
<div>What do you mean by the word initialise?</div>
<div>Are you saying that after Linux has completely booted up:</div>
<div>1. you have one computer pinging to eth0 and you can ping eth0?</div>
<div>2. if eth0 is connected to the network, you use the same computer to ping eth1 and you can ping eth1?</div>
<div>3. while you are pinging eth1 and you disconnect eth0 from the network,you can not ping eth1?<br>&nbsp;</div>
<div><span class="gmail_quote">On 9/19/07, <b class="gmail_sendername">- Reyneke</b> &lt;<a href="mailto:reynekejunk@hotmail.com">reynekejunk@hotmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">HI,<br><br>We&#39;ve run into a bit of an odd problem and we are not sure where to go and<br>look for the cause.
<br><br>We have some 440EPx based hardware with two GIG-Ethernet ports using RGMII<br>and 2x ET1011C PHY&#39;s. Problem is that eth1 will only initialise correctly<br>(i.e. receive and transmit) if eth0 has a link. Eth0 always work OK,
<br>regardless of eth1 status. Eth1 will work OK if eth0 has a link (i.e.<br>initialised) at time of setup. Once initialised, eth0 status is irrelevant.<br>All this is during Linux boot process.<br><br>Any ideas?<br><br>We can access PHY registers via u-boot (mii commands). Same 1Gig link speed
<br>is used on both ports. Linux kernel is 2.6.19.<br><br>Regards<br>&nbsp;&nbsp;Jan Reyneke<br><br>_________________________________________________________________<br>Can you see your house from the sky? Try Live Search Maps<br><a href="http://maps.live.com">
http://maps.live.com</a><br><br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_10907_2724332.1190216127038--
