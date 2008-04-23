Return-Path: <john.bonesio@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 76263DE18A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 04:52:25 +1000 (EST)
Subject: Re: XLlTemac  soft lockup BUG
From: John Bonesio <john.bonesio@xilinx.com>
To: khollan <khollan@daktronics.com>
In-Reply-To: <16834738.post@talk.nabble.com>
References: <16711066.post@talk.nabble.com>
	<42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail>
	<16734685.post@talk.nabble.com>
	<20080416225949.92427BD8076@mail18-sin.bigfish.com>
	<16834738.post@talk.nabble.com>
Content-Type: multipart/alternative; boundary="=-/nTUtYBMyalElEAlhyrz"
Date: Wed, 23 Apr 2008 11:45:28 -0700
Mime-Version: 1.0
Message-Id: <20080423184529.002029D8054@mail54-sin.bigfish.com>
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


--=-/nTUtYBMyalElEAlhyrz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Kevin,

When the system locks up, does it get stuck in the FifoRecvHandler()
routine?

How many bytes are returned from XLlFifo_RxGetLen(&lp->Fifo) in that
routine?

You can try calling XLlFifo_Reset(&lp->Fifo); to see if that clears the
fifo. Though, I suspect that this wont fix the root cause of the problem
you're seeing.

- John


On Wed, 2008-04-23 at 11:09 -0700, khollan wrote:

> Hi,
> 
> I have done some more digging and it seems like whenever the system works
> the command XLlFifo_IsRxEmpty(&lp->Fifo)) returns a 1 meaning that the
> RxFifo is empty.  I stuck this test in the xenet_open function right before
> the fifo interupt gets enabled.
> 
> When ever this test comes back as 0 the ifconfig will get into the soft
> lockup I described above.
> 
> Is there a function that empties out the fifo, I tried XLlFifo_RxReset but
> that doesn't seem to work.
> 
> Thanks
> 
> Kevin



--=-/nTUtYBMyalElEAlhyrz
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.2">
</HEAD>
<BODY>
Hi Kevin,<BR>
<BR>
When the system locks up, does it get stuck in the FifoRecvHandler() routine?<BR>
<BR>
How many bytes are returned from XLlFifo_RxGetLen(&amp;lp-&gt;Fifo) in that routine?<BR>
<BR>
You can try calling XLlFifo_Reset(&amp;lp-&gt;Fifo); to see if that clears the fifo. Though, I suspect that this wont fix the root cause of the problem you're seeing.<BR>
<BR>
- John<BR>
<BR>
<BR>
On Wed, 2008-04-23 at 11:09 -0700, khollan wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi,</FONT>

<FONT COLOR="#000000">I have done some more digging and it seems like whenever the system works</FONT>
<FONT COLOR="#000000">the command XLlFifo_IsRxEmpty(&amp;lp-&gt;Fifo)) returns a 1 meaning that the</FONT>
<FONT COLOR="#000000">RxFifo is empty.  I stuck this test in the xenet_open function right before</FONT>
<FONT COLOR="#000000">the fifo interupt gets enabled.</FONT>

<FONT COLOR="#000000">When ever this test comes back as 0 the ifconfig will get into the soft</FONT>
<FONT COLOR="#000000">lockup I described above.</FONT>

<FONT COLOR="#000000">Is there a function that empties out the fifo, I tried XLlFifo_RxReset but</FONT>
<FONT COLOR="#000000">that doesn't seem to work.</FONT>

<FONT COLOR="#000000">Thanks</FONT>

<FONT COLOR="#000000">Kevin</FONT>
</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-/nTUtYBMyalElEAlhyrz--
