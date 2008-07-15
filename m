Return-Path: <dinesh.dua@coraltele.com>
Received: from mail.coraltele.com (unknown [122.160.64.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C581DE0FD
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 22:40:43 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec	driver
From: dinesh <dinesh.dua@coraltele.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
In-Reply-To: <20080715103333.GM25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216108672.9701.5.camel@dinesh.dua>
	<20080715103333.GM25448@sirena.org.uk>
Content-Type: multipart/alternative; boundary="=-gdPuIo3hvP0aVb63iKj8"
Date: Tue, 15 Jul 2008 18:08:19 +0530
Message-Id: <1216125499.9701.16.camel@dinesh.dua>
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


--=-gdPuIo3hvP0aVb63iKj8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

thanks for your response but there is no /dev/snd directory in my file
structure is there any special method to create it please tell in
detail.


-----Original Message-----
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: dinesh <dinesh.dua@coraltele.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA SoC: Add Texas Instruments
TLV320AIC26 codec	driver
Date: Tue, 15 Jul 2008 11:33:34 +0100


On Tue, Jul 15, 2008 at 01:27:52PM +0530, dinesh wrote:

> I have one query about this soc driver.
>  I want to know when u will merge it with kernel then 
> where and by which name this device will be available
>  in /dev directory of your file system.

> As i am following the same structure for my driver so please help me. I
> am ot able to recognise the device in the file system.

It will appear via the standard ALSA interfaces (and OSS interfaces if
you enable OSS compatibility).  The standard location for ALSA device
files is under /dev/snd where you'll see several files per device.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-gdPuIo3hvP0aVb63iKj8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.18.2">
</HEAD>
<BODY>
thanks for your response but there is no /dev/snd directory in my file structure is there any special method to create it please tell in detail.<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
</TD>
</TR>
</TABLE>
<BR>
-----Original Message-----<BR>
<B>From</B>: Mark Brown &lt;<A HREF="mailto:Mark%20Brown%20%3cbroonie@opensource.wolfsonmicro.com%3e">broonie@opensource.wolfsonmicro.com</A>&gt;<BR>
<B>To</B>: dinesh &lt;<A HREF="mailto:dinesh%20%3cdinesh.dua@coraltele.com%3e">dinesh.dua@coraltele.com</A>&gt;<BR>
<B>Cc</B>: Grant Likely &lt;<A HREF="mailto:Grant%20Likely%20%3cgrant.likely@secretlab.ca%3e">grant.likely@secretlab.ca</A>&gt;, <A HREF="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</A>, <A HREF="mailto:alsa-devel@alsa-project.org">alsa-devel@alsa-project.org</A>, <A HREF="mailto:liam.girdwood@wolfsonmicro.com">liam.girdwood@wolfsonmicro.com</A><BR>
<B>Subject</B>: Re: [alsa-devel] [PATCH v2 3/3] ALSA SoC: Add Texas Instruments	TLV320AIC26 codec	driver<BR>
<B>Date</B>: Tue, 15 Jul 2008 11:33:34 +0100<BR>
<BR>
<PRE>
On Tue, Jul 15, 2008 at 01:27:52PM +0530, dinesh wrote:

&gt; I have one query about this soc driver.
&gt;  I want to know when u will merge it with kernel then 
&gt; where and by which name this device will be available
&gt;  in /dev directory of your file system.

&gt; As i am following the same structure for my driver so please help me. I
&gt; am ot able to recognise the device in the file system.

It will appear via the standard ALSA interfaces (and OSS interfaces if
you enable OSS compatibility).  The standard location for ALSA device
files is under /dev/snd where you'll see several files per device.
_______________________________________________
Alsa-devel mailing list
<A HREF="mailto:Alsa-devel@alsa-project.org">Alsa-devel@alsa-project.org</A>
<A HREF="http://mailman.alsa-project.org/mailman/listinfo/alsa-devel">http://mailman.alsa-project.org/mailman/listinfo/alsa-devel</A>
</PRE>
</BODY>
</HTML>

--=-gdPuIo3hvP0aVb63iKj8--
