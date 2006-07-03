Return-Path: <bwarren@qstreams.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 276EB679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 00:36:08 +1000 (EST)
Subject: RE: JFFS2 FS is read-only (not what I want)
From: Ben Warren <bwarren@qstreams.com>
To: Anantharaman Chetan-W16155 <Chetan.S.Anantharaman@motorola.com>
In-Reply-To: <EDF27F298D4B03498AE0C249A941DFF803D748@de01exm68.ds.mot.com>
References: <EDF27F298D4B03498AE0C249A941DFF803D748@de01exm68.ds.mot.com>
Content-Type: multipart/alternative; boundary="=-UsOq8GEroiKmTsnRKHjZ"
Date: Mon, 03 Jul 2006 10:36:05 -0400
Message-Id: <1151937365.12449.17.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-UsOq8GEroiKmTsnRKHjZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Chetan,

On Mon, 2006-07-03 at 10:18 -0400, Anantharaman Chetan-W16155 wrote:

> Did you check to see if your flash banks are unlocked?
> 

According to U-Boot, only the first four sectors are locked.  My JFFS2
partition is in sectors 37-52 (1-based).  I'll definitely look more
deeply into this, though.

thanks,
Ben

--=-UsOq8GEroiKmTsnRKHjZ
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.10.2">
</HEAD>
<BODY>
Chetan,<BR>
<BR>
On Mon, 2006-07-03 at 10:18 -0400, Anantharaman Chetan-W16155 wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Did you check to see if your flash banks are unlocked?</FONT>

</PRE>
</BLOCKQUOTE>
According to U-Boot, only the first four sectors are locked.&nbsp; My JFFS2 partition is in sectors 37-52 (1-based).&nbsp; I'll definitely look more deeply into this, though.<BR>
<BR>
thanks,<BR>
Ben
</BODY>
</HTML>

--=-UsOq8GEroiKmTsnRKHjZ--
