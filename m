Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 644052BF0D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 00:37:26 +1100 (EST)
To: "Chris Down" <chris@alcor.co.uk>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Nov 2004 12:43:33 GMT."
	<000001c4ce35$6194b260$0101a8c0@alcor1>
Date: Fri, 19 Nov 2004 14:36:54 +0100
Sender: wd@denx.de
Message-Id: <20041119133659.3DAA2C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problem bringing up Linux on Custom MPC852 Board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <000001c4ce35$6194b260$0101a8c0@alcor1> you wrote:
>
> The solution was a lot simpler, there was no problem with the SDRAM
> initialisation. The cause was due to the fact that I had a BDI2000
> connected and
> the SYSIE bit was enabled in the DER for flash programming. Clearing

There is no need to set SYSIE.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
We want to create puppets that pull their own strings.   - Ann Marion
