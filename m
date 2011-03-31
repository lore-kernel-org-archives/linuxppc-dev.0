Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
	[209.85.210.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 361A3B6ED0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2011 14:43:35 +1100 (EST)
Received: by iyb12 with SMTP id 12so2319826iyb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2011 20:43:31 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 30 Mar 2011 21:43:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: How to define an I2C-to-SPI bridge device ?
Message-ID: <20110331034328.GA21226@ponder.secretlab.ca>
References: <1283502979.17812.22.camel@swa-m460>
	<20100903120858.GA19380@oksana.dev.rtsoft.ru>
	<4C84D334.6060008@matrix-vision.de>
	<c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
	<4D8C603F.6060501@matrix-vision.de>
	<4D92071E.3060906@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D92071E.3060906@matrix-vision.de>
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 29, 2011 at 06:21:50PM +0200, Andre Schwarz wrote:
> On 03/25/2011 10:28 AM, Andre Schwarz wrote:
> >Grant, Anton,
> 
> got it.
> providing modalis = "spidev" within spi_board_info works like a charme ...

Good.  Glad you got it sorted out.

g.
