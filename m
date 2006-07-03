Return-Path: <bwarren@qstreams.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id DC33667B75
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 00:19:47 +1000 (EST)
Subject: Re: JFFS2 FS is read-only (not what I want)
From: Ben Warren <bwarren@qstreams.com>
To: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
In-Reply-To: <200607031241.27979.mathieu.deschamps@com2gether.net>
References: <44A6E57A.3080302@qstreams.com>
	<200607031241.27979.mathieu.deschamps@com2gether.net>
Content-Type: multipart/alternative; boundary="=-SOEuVoAMtFQbOz+Tj3a9"
Date: Mon, 03 Jul 2006 10:19:44 -0400
Message-Id: <1151936384.12449.12.camel@saruman.qstreams.net>
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


--=-SOEuVoAMtFQbOz+Tj3a9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Mathieu,

Thanks for responding!

On Mon, 2006-07-03 at 12:42 +0200, Mathieu Deschamps wrote:


> >
> Do you mean that you can't even created a void file on / as root ? Else
> can you then put for instance text in it ? My point is can or can't you
> first create a new fs node and then can you write to file your
> changes, that's two possible causes.

# pwd
/
# touch newfile
touch: newfile: No space left on device
#


> Yes indeed what about drivers/mtd/maps/physmap.c ? your parts are
> mask_flags:  MTD_WRITEB_WRITEABLE and not  MTD_CAP_ROM,
> aren't they ?
> 

My chip is pretty standard NOR type Flash, and gets recognized by CFI as
using command set 0001.  It gets these flags:
#define MTD_CAP_NORFLASH        (MTD_CLEAR_BITS|MTD_ERASEABLE)


> > ***
> > # Memory Technology Devices (MTD)
> > #
> > CONFIG_MTD=y
> > # CONFIG_MTD_DEBUG is not set
> > # CONFIG_MTD_CONCAT is not set
> > CONFIG_MTD_PARTITIONS=y
> > # CONFIG_MTD_REDBOOT_PARTS is not set
> > # CONFIG_MTD_CMDLINE_PARTS is not set
> >
> [...]
> > # CONFIG_JFFS_FS is not set
> > CONFIG_JFFS2_FS=y
> 
> Better avoid redundacy but this is not a clue, I guess
> make won't be fooled by this.
> 

Sorry, what's redundant here?  I just used 'make menuconfig', and
hopefully it notices incorrect options.


> 
> IMHO, it's not a generation-time issue
> 
> >

Good.  I'll keep plugging away with my BDI

thanks again,
Ben

--=-SOEuVoAMtFQbOz+Tj3a9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.10.2">
</HEAD>
<BODY>
Mathieu,<BR>
<BR>
Thanks for responding!<BR>
<BR>
On Mon, 2006-07-03 at 12:42 +0200, Mathieu Deschamps wrote:<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">Do you mean that you can't even created a void file on / as root ? Else</FONT>
<FONT COLOR="#000000">can you then put for instance text in it ? My point is can or can't you</FONT>
<FONT COLOR="#000000">first create a new fs node and then can you write to file your</FONT>
<FONT COLOR="#000000">changes, that's two possible causes.</FONT>
</PRE>
</BLOCKQUOTE>
# pwd<BR>
/<BR>
# touch newfile<BR>
touch: newfile: No space left on device<BR>
#<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Yes indeed what about drivers/mtd/maps/physmap.c ? your parts are</FONT>
<FONT COLOR="#000000">mask_flags:  MTD_WRITEB_WRITEABLE and not  MTD_CAP_ROM,</FONT>
<FONT COLOR="#000000">aren't they ?</FONT>

</PRE>
</BLOCKQUOTE>
My chip is pretty standard NOR type Flash, and gets recognized by CFI as using command set 0001.&nbsp; It gets these flags:<BR>
#define MTD_CAP_NORFLASH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (MTD_CLEAR_BITS|MTD_ERASEABLE)<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">&gt; ***</FONT>
<FONT COLOR="#000000">&gt; # Memory Technology Devices (MTD)</FONT>
<FONT COLOR="#000000">&gt; #</FONT>
<FONT COLOR="#000000">&gt; CONFIG_MTD=y</FONT>
<FONT COLOR="#000000">&gt; # CONFIG_MTD_DEBUG is not set</FONT>
<FONT COLOR="#000000">&gt; # CONFIG_MTD_CONCAT is not set</FONT>
<FONT COLOR="#000000">&gt; CONFIG_MTD_PARTITIONS=y</FONT>
<FONT COLOR="#000000">&gt; # CONFIG_MTD_REDBOOT_PARTS is not set</FONT>
<FONT COLOR="#000000">&gt; # CONFIG_MTD_CMDLINE_PARTS is not set</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">[...]</FONT>
<FONT COLOR="#000000">&gt; # CONFIG_JFFS_FS is not set</FONT>
<FONT COLOR="#000000">&gt; CONFIG_JFFS2_FS=y</FONT>

<FONT COLOR="#000000">Better avoid redundacy but this is not a clue, I guess</FONT>
<FONT COLOR="#000000">make won't be fooled by this.</FONT>

</PRE>
</BLOCKQUOTE>
Sorry, what's redundant here?&nbsp; I just used 'make menuconfig', and hopefully it notices incorrect options.<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>

<FONT COLOR="#000000">IMHO, it's not a generation-time issue</FONT>

<FONT COLOR="#000000">&gt;</FONT>
</PRE>
</BLOCKQUOTE>
Good.&nbsp; I'll keep plugging away with my BDI<BR>
<BR>
thanks again,<BR>
Ben
</BODY>
</HTML>

--=-SOEuVoAMtFQbOz+Tj3a9--
