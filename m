Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id BDA2A2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Nov 2004 07:17:01 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 16 Nov 2004 13:16:54 -0700
To: roger blofeld <blofeldus@yahoo.com>
Message-ID: <20041116201654.GA3088@xyzzy>
References: <20041115173402.GA22661@xyzzy>
	<20041116182609.68313.qmail@web53502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041116182609.68313.qmail@web53502.mail.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 FEC Driver on linux 2.6 broken? (again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Nov 16, 2004 at 10:26:09AM -0800, roger blofeld wrote:
> Retransmissions from the lite5200 work OK now, but the occasional ACK
> packet is sent from the lite5200 with a bad checksum causing
> retransmissions. Perhaps another patch would fix this problem too?

I too have seen occasional errors, but I don't think it's a software
issue.

-Dale
