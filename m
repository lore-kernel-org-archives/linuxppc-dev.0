Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id EF3D0DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 16:53:58 +1100 (EST)
Message-ID: <4785B2F5.6040001@pikatech.com>
Date: Thu, 10 Jan 2008 00:53:57 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: How complete should the DTS be?
References: <4782DAD8.1080104@pikatech.com>
	<86AA8535-E2CF-4891-900B-340049A5CA19@kernel.crashing.org>
	<20080110031331.GF17816@localhost.localdomain>
In-Reply-To: <20080110031331.GF17816@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> Hrm... I'd say this is not something which has a firm convention yet.
> It's going to become more of an issue once we get a macros system for
> dtc, so the "440EP" macro would have all the devices, even if some are
> not connected on a given board.
>
> I'm contemplating suggesting that we adopt the "status" property from
> IEEE1275 to cover this.
>
>   
When I am laying out the dts, leaving out what isn't used makes the dts 
file cleaner, at least in my view. It doesn't hurt to have the second 
i2c bus there, but it also doesn't help and leaving it out points out 
that it is not used.

When we get a macro system I assume the second i2c bus will be there but 
hidden by a macro. It will still be clean and shouldn't cause grief.

Cheers,
    Sean
