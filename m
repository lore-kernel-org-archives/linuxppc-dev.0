Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 1C6922BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 06:54:46 +1000 (EST)
Date: Wed, 13 Oct 2004 13:54:44 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Mark Chambers <markc@mail.com>
Message-ID: <20041013135444.B21277@home.com>
References: <065ACD8E84315E4394C835E398C8D5EB865270@COSSMGMBX02.email.corp.tld>
	<20041013132613.A21277@home.com>
	<00d001c4b166$04a06ea0$0301a8c0@chuck2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00d001c4b166$04a06ea0$0301a8c0@chuck2>;
	from markc@mail.com on Wed, Oct 13, 2004 at 04:48:34PM -0400
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

On Wed, Oct 13, 2004 at 04:48:34PM -0400, Mark Chambers wrote:
> 
> 
> > On Wed, Oct 13, 2004 at 02:18:03PM -0600, VanBaren, Gerald (AGRE) wrote:
> > > Just to mess with your minds... I2C is a trademark of Philips
> > > Electronics N.V. so that is probably not the best choice from a
> > > legalistic point of view.
> > 
> > It's been related to me several times that this is the reason why
> > most implementers refer to their interface/bus as IIC in
> > documentation.
>
> Assuming this to be true, it still may be a bit misguided.  Using 'i2c' to
> refer to a legal implementation is no more illegal than a restaurant
> putting 'Coke' on their menu.  What does Philips want?  They want
> royalties from implementations of i2c, and they do not want the term
> diluted by using it to refer to other similar protocols.  So I don't
> think that just changing to 'iic' would pacify them in either of these
> cases.  If it's truly i2c I don't think they care what you call your
> variables, (just so the chip manufacturer pays up) and if it's not, 
> find a completely different name.

I was talking about the trademark infringement. You are talking about
something completely different, patent-encumbered licensable
technology.  The naming is subject only to trademark considerations.

Whether a bus implementation is subject to Philips licensing
requirements (if any) is another area I'm not interested in. :)

-Matt
