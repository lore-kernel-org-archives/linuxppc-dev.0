Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 33FF22BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 05:13:29 +1000 (EST)
Date: Wed, 13 Oct 2004 14:56:00 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Mark Chambers <markc@mail.com>
In-Reply-To: <005601c4b155$8ae3fbf0$0301a8c0@chuck2>
Message-ID: <Pine.LNX.4.60.0410131453130.13195@localhost.localdomain>
References: <Pine.LNX.4.60.0410131423540.12426@localhost.localdomain>
	<005601c4b155$8ae3fbf0$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: "I2C" versus "IIC"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 Oct 2004, Mark Chambers wrote:

> ----- Original Message -----
> From: "Robert P. J. Day" <rpjday@mindspring.com>
> To: "Embedded PPC Linux list" <linuxppc-embedded@ozlabs.org>
> Sent: Wednesday, October 13, 2004 2:26 PM
> Subject: "I2C" versus "IIC"
>
> My vote, since nobody asked, would be "I2C".  I've always heard people
> say "I squared C", and since only CBS can get superscripts out of ASCII
> I2C is about as close as you can get.  I2C is more unique and hence
> a more readily recognizable acronym.
>
> But I'm sure we could get about 50/50 voting on this.

oh, probably. :-)  i realize it sounds nitpicky and pedantic, but it
would have been nice if the source was consistent on this.  but based
on my grep of the tree, i don't see that that's possible -- too many
examples of each.  it's kind of a mess.  personally, i'd prefer a
consistent usage of "i2c" or "I2C" as well, but i just don't see it
happening.

rday
