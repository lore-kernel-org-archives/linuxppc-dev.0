Return-Path: <mjoshi_blr@yahoo.com>
Received: from web34715.mail.mud.yahoo.com (web34715.mail.mud.yahoo.com
	[209.191.68.164]) by ozlabs.org (Postfix) with SMTP id 14A1367B9E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 06:25:30 +1000 (EST)
Message-ID: <20060803201848.45985.qmail@web34715.mail.mud.yahoo.com>
Date: Thu, 3 Aug 2006 13:18:48 -0700 (PDT)
From: Manish Joshi <mjoshi_blr@yahoo.com>
Subject: Re: DMA Driver on MPC8260
To: jimmy liu <jimmyzhmliu@yahoo.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <20060803152112.13604.qmail@web53103.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1172259605-1154636328=:44790"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1172259605-1154636328=:44790
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

What kind of information you are looking for? Specific questions always help.
  General details you can find in the user manual itself. 
   
  Not sure, but I think MPC8260 has 4 DMA channels which can be programmed independently. You need to set the mode registers and then the src/dest addr registers and byte count and finally turn on the start bit. 
  

jimmy liu <jimmyzhmliu@yahoo.com> wrote:
  I am working on PCI transactions between MPC8260 and
FPGA. Could somebody give me some information about
the PCI DMA Driver on MPC8260?

Thanks.


__________________________________________________
Do You Yahoo!?
Tired of spam? Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


 				
---------------------------------
Want to be your own boss? Learn how on  Yahoo! Small Business. 
--0-1172259605-1154636328=:44790
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>What kind of information you are looking for? Specific questions always help.</div>  <div>General details you can find in the user manual itself. </div>  <div>&nbsp;</div>  <div>Not sure, but I think MPC8260 has 4 DMA channels which can be programmed independently. You need to set the mode registers and then the src/dest addr registers and byte count and finally turn on the start bit. </div>  <div><BR><BR><B><I>jimmy liu &lt;jimmyzhmliu@yahoo.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">I am working on PCI transactions between MPC8260 and<BR>FPGA. Could somebody give me some information about<BR>the PCI DMA Driver on MPC8260?<BR><BR>Thanks.<BR><BR><BR>__________________________________________________<BR>Do You Yahoo!?<BR>Tired of spam? Yahoo! Mail has the best spam protection around <BR>http://mail.yahoo.com <BR>_______________________________________________<BR>Linuxppc-embedded
 mailing list<BR>Linuxppc-embedded@ozlabs.org<BR>https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR></BLOCKQUOTE><BR><p>&#32;
	
	
		<hr size=1>Want to be your own boss? Learn how on <a href="http://us.rd.yahoo.com/evt=41244/*http://smallbusiness.yahoo.com/r-index"> Yahoo! Small Business.</a> 

--0-1172259605-1154636328=:44790--
