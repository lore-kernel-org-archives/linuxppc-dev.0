Return-Path: <bwarren@qstreams.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id C8FD467B6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 06:12:47 +1000 (EST)
Subject: Re: JFFS2 FS is read-only (not what I want)
From: Ben Warren <bwarren@qstreams.com>
To: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
In-Reply-To: <1151955491.12449.32.camel@saruman.qstreams.net>
References: <44A6E57A.3080302@qstreams.com>
	<200607031241.27979.mathieu.deschamps@com2gether.net>
	<1151955491.12449.32.camel@saruman.qstreams.net>
Content-Type: multipart/alternative; boundary="=-9vi7df46Ll67XA6IWn8T"
Date: Mon, 03 Jul 2006 16:12:44 -0400
Message-Id: <1151957564.12449.39.camel@saruman.qstreams.net>
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


--=-9vi7df46Ll67XA6IWn8T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

 On Mon, 2006-07-03 at 15:38 -0400, Ben Warren wrote:


> This is starting to look to me like a generation-time issue.  I built
> another JFFS2 partition out of a random directory on my workstation, and
> it's behaving properly:

Sorry for filling people's inboxes, but it turns out the problem was
between the chair and keyboard.  My JFFS2 partition was slightly less
than 2MB, which I guess decompresses to > 2 MB, filling up the
partition.  I must have been in the wrong directory when issuing the
'du' command.  On the plus side, I've learned quite a bit about MTD and
JFFS2 going through this exercise!

regards,
Ben

--=-9vi7df46Ll67XA6IWn8T
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.10.2">
</HEAD>
<BODY>
 On Mon, 2006-07-03 at 15:38 -0400, Ben Warren wrote:<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">This is starting to look to me like a generation-time issue.  I built</FONT>
<FONT COLOR="#000000">another JFFS2 partition out of a random directory on my workstation, and</FONT>
<FONT COLOR="#000000">it's behaving properly:</FONT>
</PRE>
</BLOCKQUOTE>
Sorry for filling people's inboxes, but it turns out the problem was between the chair and keyboard.&nbsp; My JFFS2 partition was slightly less than 2MB, which I guess decompresses to &gt; 2 MB, filling up the partition.&nbsp; I must have been in the wrong directory when issuing the 'du' command.&nbsp; On the plus side, I've learned quite a bit about MTD and JFFS2 going through this exercise!<BR>
<BR>
regards,<BR>
Ben
</BODY>
</HTML>

--=-9vi7df46Ll67XA6IWn8T--
