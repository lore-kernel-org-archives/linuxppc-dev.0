Return-Path: <bwarren@qstreams.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id BEB8E67B8F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 07:42:52 +1000 (EST)
Subject: Re: Knowing kernel module load address (insmod hasn't -m)
From: Ben Warren <bwarren@qstreams.com>
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
In-Reply-To: <200607132327.58708.antonio.dibacco@aruba.it>
References: <200607132238.11177.antonio.dibacco@aruba.it>
	<1152824648.5238.12.camel@saruman.qstreams.net>
	<200607132327.58708.antonio.dibacco@aruba.it>
Content-Type: multipart/alternative; boundary="=-YHWWYKfQ5t6rJM0lRlKm"
Date: Thu, 13 Jul 2006 17:42:49 -0400
Message-Id: <1152826969.5238.16.camel@saruman.qstreams.net>
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


--=-YHWWYKfQ5t6rJM0lRlKm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

/proc/modules support is in 2.4, but the other stuff is 2.6 only (I
believe somewhere around 2.6.11 or so?)  You should be able to 'insmod
-m' in 2.4.  You may need to reconfigure busybox or use a non-busybox
'insmod', though.

cheers,
Ben
 
On Thu, 2006-07-13 at 23:27 +0200, Antonio Di Bacco wrote:

> > cat /proc/modules
> >
> > If you want more detailed information about a module (locations
> > of .text, .data, .bss etc), enable CONFIG_KALLSYMS in your kernel and
> 
> Does this option exist in kernel 2.4 too? I didn't find it!
> 
> Thank you,
> Antonio.

--=-YHWWYKfQ5t6rJM0lRlKm
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.10.2">
</HEAD>
<BODY>
/proc/modules support is in 2.4, but the other stuff is 2.6 only (I believe somewhere around 2.6.11 or so?)&nbsp; You should be able to 'insmod -m' in 2.4.&nbsp; You may need to reconfigure busybox or use a non-busybox 'insmod', though.<BR>
<BR>
cheers,<BR>
Ben<BR>
 <BR>
On Thu, 2006-07-13 at 23:27 +0200, Antonio Di Bacco wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">&gt; cat /proc/modules</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; If you want more detailed information about a module (locations</FONT>
<FONT COLOR="#000000">&gt; of .text, .data, .bss etc), enable CONFIG_KALLSYMS in your kernel and</FONT>

<FONT COLOR="#000000">Does this option exist in kernel 2.4 too? I didn't find it!</FONT>

<FONT COLOR="#000000">Thank you,</FONT>
<FONT COLOR="#000000">Antonio.</FONT>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-YHWWYKfQ5t6rJM0lRlKm--
