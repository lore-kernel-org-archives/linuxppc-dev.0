Return-Path: <jimmyzhmliu@yahoo.com>
Received: from web53109.mail.yahoo.com (web53109.mail.yahoo.com
	[206.190.49.59]) by ozlabs.org (Postfix) with SMTP id AF86567B87
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 07:35:09 +1000 (EST)
Message-ID: <20060803213507.93830.qmail@web53109.mail.yahoo.com>
Date: Thu, 3 Aug 2006 14:35:07 -0700 (PDT)
From: jimmy liu <jimmyzhmliu@yahoo.com>
Subject: Re: DMA Driver on MPC8260
To: Manish Joshi <mjoshi_blr@yahoo.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <20060803201848.45985.qmail@web34715.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You are 100% right. MPC8260 has 4 DMA channels which
can be programmed independently. Could I find some
sample code from some place?

--- Manish Joshi <mjoshi_blr@yahoo.com> wrote:

> What kind of information you are looking for?
> Specific questions always help.
>   General details you can find in the user manual
> itself. 
>    
>   Not sure, but I think MPC8260 has 4 DMA channels
> which can be programmed independently. You need to
> set the mode registers and then the src/dest addr
> registers and byte count and finally turn on the
> start bit. 
>   
> 
> jimmy liu <jimmyzhmliu@yahoo.com> wrote:
>   I am working on PCI transactions between MPC8260
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
> Want to be your own boss? Learn how on  Yahoo! Small
> Business. 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
