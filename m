Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61A70DDE9F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 06:29:50 +1100 (EST)
In-Reply-To: <F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
References: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
	<F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4121A086-A316-4BCC-A459-7DF34831F471@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: macros and dtc
Date: Mon, 19 Feb 2007 13:28:33 -0600
To: Dan Malek <dan@embeddedalley.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2007, at 12:07 PM, Dan Malek wrote:

>
> On Feb 18, 2007, at 11:58 AM, Kumar Gala wrote:
>
>> After spending some time this weekend cleaning up dts files I figured
>> it would be nice if we can some to consensus on how we are going to
>> do macro support.
>
> I'm not sure I'd like to use macros.  I can understand the case
> today where we are still changing too many things that a
> macro would be nice, but at some point this has to settle down.
> There isn't that much information in the file, and I prefer to
> see all of it clearly rather than locating macros to wonder
> how they need to be invoked.
>
>> There is clearly a lot of duplication between
>> dts's and it only gets worse when you add in slight variations for
>> revs of boards.
>
> Of the few boards for which I've had to create new dts
> files, I wonder how the macros would work.  Although the
> variations are slight, there are many variables.  A macro
> is going to have to allow nearly all of the property information
> as parameters, so what's the big savings?  If you are
> just using them to avoid syntax, then perhaps we should
> have chosen a different syntax? :-)  I think a macro with
> lots of parameters is more confusing than the syntax
> we currently use.

Well, I was thinking one useful place would be the PCI range macro.   
Without reading the PCI OF spec 3 or 4 times, its pretty confusing to  
parse what's going on there.

> I could envision using something like cpp with #include
> to get some standard SOC block properties, but macros
> that try to account for board variations could be quite
> complex.

Agreed, I'm think some simple SOC block's like TSEC would be useful.

I think its something we need to play with and see how it works out.

- k
