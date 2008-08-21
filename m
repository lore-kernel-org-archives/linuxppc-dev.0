Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 239B7DE10C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 13:18:24 +1000 (EST)
Date: Wed, 20 Aug 2008 23:18:28 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: Strange behavior with I2C on Sequoia board
Message-ID: <20080820231828.3c22da08@lappy.seanm.ca>
In-Reply-To: <1219279463.26429.35.camel@jdub.homelinux.org>
References: <48AC84D9.8050809@harris.com>
	<1219279463.26429.35.camel@jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Aug 2008 20:44:23 -0400
"Josh Boyer" <jwboyer@gmail.com> wrote:

> That's all output from the wrapper, not the kernel.  And the kernel
> config doesn't make a difference at all to the wrapper.  I wonder if
> there is some weird size issue going on there or if whatever U-Boot
> version you are using is doing odd things...

Any chance something in the DTS could affect it? Maybe try commenting
out the second IIC controller?

Cheers,
   Sean
