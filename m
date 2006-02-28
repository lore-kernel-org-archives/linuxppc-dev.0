Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 10C5567A3E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Mar 2006 07:58:15 +1100 (EST)
To: "Laurent Lagrange" <lagrange@fr.oleane.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Minor bug in file irq.h 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 Feb 2006 09:50:50 +0100."
	<000201c63c44$14a9c1b0$5201a8c0@GEG2400>
Date: Tue, 28 Feb 2006 21:58:12 +0100
Sender: wd@denx.de
Message-Id: <20060228205812.257AA35260E@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <000201c63c44$14a9c1b0$5201a8c0@GEG2400> you wrote:
> 
> In the ./linux/include/asm-ppc/irq.h file, I encountered a problem with the
> timer3 interrupt definition :
> #define     SIU_INT_TIMER3          ((uint)0x0e+CPM_IRQ_OFFSET)
> 
> This definition generates a compilation error  because is interpreted as

Note that this is not the only such definition. At least this one  is
critical, too:

	#define SIU_INT_PC1             ((uint)0x3e+CPM_IRQ_OFFSET)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Here's a fish hangs in the net like a poor man's right in  the  law.
'Twill hardly come out."     - Shakespeare, Pericles, Act II, Scene 1
