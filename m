Return-Path: <dinesh.dua@coraltele.com>
Received: from mail.coraltele.com (unknown [122.160.64.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF7CEDDFAB
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 20:15:54 +1000 (EST)
Subject: Re: [alsa-devel] WRITING AN SOC DRIVER WITHOUT DMA
From: dinesh <dinesh.dua@coraltele.com>
To: Nobin Mathew <nobin.mathew@gmail.com>
In-Reply-To: <8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216199130.749.4.camel@dinesh.dua>
	<8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
Content-Type: multipart/alternative; boundary="=-jHVb8xnMEFt8IqcSJcLB"
Date: Wed, 16 Jul 2008 15:43:26 +0530
Message-Id: <1216203206.9723.0.camel@dinesh.dua>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jHVb8xnMEFt8IqcSJcLB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

no i am working on powerpc.     MPC8323


-----Original Message-----
From: Nobin Mathew <nobin.mathew@gmail.com>
To: dinesh <dinesh.dua@coraltele.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
Subject: Re: [alsa-devel] WRITING AN SOC DRIVER WITHOUT DMA
Date: Wed, 16 Jul 2008 15:37:54 +0530


Hi dinesh,

If you are working on ARM, see the ARM AACi code, in sound/arm/aaci.c

Thanks
Nobin Mathew.


On 7/16/08, dinesh <dinesh.dua@coraltele.com> wrote:
>
> Hi,
> I am writing a soc sound driver for MPC8323 board linux 2.6.24 in which i
> want to do data transfer to and from device myself using BUFFER DESCRIPTOR
> not with the usual DMA transfer.
> Please help me.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-jHVb8xnMEFt8IqcSJcLB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.18.2">
</HEAD>
<BODY>
no i am working on powerpc.&nbsp;&nbsp;&nbsp;&nbsp; MPC8323<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
</TD>
</TR>
</TABLE>
<BR>
-----Original Message-----<BR>
<B>From</B>: Nobin Mathew &lt;<A HREF="mailto:Nobin%20Mathew%20%3cnobin.mathew@gmail.com%3e">nobin.mathew@gmail.com</A>&gt;<BR>
<B>To</B>: dinesh &lt;<A HREF="mailto:dinesh%20%3cdinesh.dua@coraltele.com%3e">dinesh.dua@coraltele.com</A>&gt;<BR>
<B>Cc</B>: Grant Likely &lt;<A HREF="mailto:Grant%20Likely%20%3cgrant.likely@secretlab.ca%3e">grant.likely@secretlab.ca</A>&gt;, <A HREF="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</A>, <A HREF="mailto:alsa-devel@alsa-project.org">alsa-devel@alsa-project.org</A>, <A HREF="mailto:liam.girdwood@wolfsonmicro.com">liam.girdwood@wolfsonmicro.com</A><BR>
<B>Subject</B>: Re: [alsa-devel] WRITING AN SOC DRIVER WITHOUT DMA<BR>
<B>Date</B>: Wed, 16 Jul 2008 15:37:54 +0530<BR>
<BR>
<PRE>
Hi dinesh,

If you are working on ARM, see the ARM AACi code, in sound/arm/aaci.c

Thanks
Nobin Mathew.


On 7/16/08, dinesh &lt;<A HREF="mailto:dinesh.dua@coraltele.com">dinesh.dua@coraltele.com</A>&gt; wrote:
&gt;
&gt; Hi,
&gt; I am writing a soc sound driver for MPC8323 board linux 2.6.24 in which i
&gt; want to do data transfer to and from device myself using BUFFER DESCRIPTOR
&gt; not with the usual DMA transfer.
&gt; Please help me.
&gt; _______________________________________________
&gt; Alsa-devel mailing list
&gt; <A HREF="mailto:Alsa-devel@alsa-project.org">Alsa-devel@alsa-project.org</A>
&gt; <A HREF="http://mailman.alsa-project.org/mailman/listinfo/alsa-devel">http://mailman.alsa-project.org/mailman/listinfo/alsa-devel</A>
&gt;
_______________________________________________
Alsa-devel mailing list
<A HREF="mailto:Alsa-devel@alsa-project.org">Alsa-devel@alsa-project.org</A>
<A HREF="http://mailman.alsa-project.org/mailman/listinfo/alsa-devel">http://mailman.alsa-project.org/mailman/listinfo/alsa-devel</A>
</PRE>
</BODY>
</HTML>

--=-jHVb8xnMEFt8IqcSJcLB--
