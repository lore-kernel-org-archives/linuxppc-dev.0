Return-Path: <mjoshi_blr@yahoo.com>
Received: from web34704.mail.mud.yahoo.com (web34704.mail.mud.yahoo.com
	[209.191.68.153]) by ozlabs.org (Postfix) with SMTP id 4E84F67B95
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 09:09:32 +1000 (EST)
Message-ID: <20060803230931.28100.qmail@web34704.mail.mud.yahoo.com>
Date: Thu, 3 Aug 2006 16:09:31 -0700 (PDT)
From: Manish Joshi <mjoshi_blr@yahoo.com>
Subject: Re: DMA Driver on MPC8260
To: jimmy liu <jimmyzhmliu@yahoo.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <20060803213507.93830.qmail@web53109.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-960873631-1154646571=:27321"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-960873631-1154646571=:27321
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

No idea about sample code.
  But I think programming DMA itself is straightforward as mentioned below.
  Just ensure to use uncached physical memory for src/dest addresses. 
  Then you can program your interrupt to receive the DMA completion notification.
   
  There are couple of registers like ESR, DMASR etc which you can check in case you see any issues after programming your DMA config registers which are little endian.

jimmy liu <jimmyzhmliu@yahoo.com> wrote:
  You are 100% right. MPC8260 has 4 DMA channels which
can be programmed independently. Could I find some
sample code from some place?

--- Manish Joshi wrote:

> What kind of information you are looking for?
> Specific questions always help.
> General details you can find in the user manual
> itself. 
> 
> Not sure, but I think MPC8260 has 4 DMA channels
> which can be programmed independently. You need to
> set the mode registers and then the src/dest addr
> registers and byte count and finally turn on the
> start bit. 
> 
> 
> jimmy liu wrote:
> I am working on PCI transactions between MPC8260
> and
> FPGA. Could somebody give me some information about
> the PCI DMA Driver on MPC8260?
> 
> Thanks.
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam? Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> 
> ---------------------------------
> Want to be your own boss? Learn how on Yahoo! Small
> Business. 


__________________________________________________
Do You Yahoo!?
Tired of spam? Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


 				
---------------------------------
Want to be your own boss? Learn how on  Yahoo! Small Business. 
--0-960873631-1154646571=:27321
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>No idea about sample code.</div>  <div>But I think programming DMA itself is straightforward as mentioned below.</div>  <div>Just ensure to use uncached physical memory for src/dest addresses. </div>  <div>Then you can program your interrupt to receive the DMA completion notification.</div>  <div>&nbsp;</div>  <div>There are couple of registers like ESR, DMASR etc which you can check in case you see any issues after programming your DMA config registers which are little endian.<BR><BR><B><I>jimmy liu &lt;jimmyzhmliu@yahoo.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">You are 100% right. MPC8260 has 4 DMA channels which<BR>can be programmed independently. Could I find some<BR>sample code from some place?<BR><BR>--- Manish Joshi <MJOSHI_BLR@YAHOO.COM>wrote:<BR><BR>&gt; What kind of information you are looking for?<BR>&gt; Specific questions always help.<BR>&gt; General details you can
 find in the user manual<BR>&gt; itself. <BR>&gt; <BR>&gt; Not sure, but I think MPC8260 has 4 DMA channels<BR>&gt; which can be programmed independently. You need to<BR>&gt; set the mode registers and then the src/dest addr<BR>&gt; registers and byte count and finally turn on the<BR>&gt; start bit. <BR>&gt; <BR>&gt; <BR>&gt; jimmy liu <JIMMYZHMLIU@YAHOO.COM>wrote:<BR>&gt; I am working on PCI transactions between MPC8260<BR>&gt; and<BR>&gt; FPGA. Could somebody give me some information about<BR>&gt; the PCI DMA Driver on MPC8260?<BR>&gt; <BR>&gt; Thanks.<BR>&gt; <BR>&gt; <BR>&gt; __________________________________________________<BR>&gt; Do You Yahoo!?<BR>&gt; Tired of spam? Yahoo! Mail has the best spam<BR>&gt; protection around <BR>&gt; http://mail.yahoo.com <BR>&gt; _______________________________________________<BR>&gt; Linuxppc-embedded mailing list<BR>&gt; Linuxppc-embedded@ozlabs.org<BR>&gt;<BR>https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR>&gt; <BR>&gt;
 <BR>&gt; <BR>&gt; ---------------------------------<BR>&gt; Want to be your own boss? Learn how on Yahoo! Small<BR>&gt; Business. <BR><BR><BR>__________________________________________________<BR>Do You Yahoo!?<BR>Tired of spam? Yahoo! Mail has the best spam protection around <BR>http://mail.yahoo.com <BR></BLOCKQUOTE><BR><p>&#32;
	
	
		<hr size=1>Want to be your own boss? Learn how on <a href="http://us.rd.yahoo.com/evt=41244/*http://smallbusiness.yahoo.com/r-index"> Yahoo! Small Business.</a> 

--0-960873631-1154646571=:27321--
