Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id A518667A7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 07:00:32 +1100 (EST)
To: "Stephen Warren" <SWarren@nvidia.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Mar 2005 11:09:40 PST."
	<DBFABB80F7FD3143A911F9E6CFD477B0056A92CC@hqemmail02.nvidia.com>
Date: Tue, 08 Mar 2005 21:00:01 +0100
Sender: wd@denx.de
Message-Id: <20050308200006.C3390C1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 kernel with IDE *and* FEC? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <DBFABB80F7FD3143A911F9E6CFD477B0056A92CC@hqemmail02.nvidia.com> you wrote:
>
> We've used IDE (for a DVD-ROM) using the Denx kernel. This didn't have
> DMA suppport, but Freescale gave us a derivate kernel that it, which

The kernel on our CVS server does support DMA - at least to the lavel
that is available with the current IDE driver and microcode.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
On a clear disk you can seek forever.
