Date: Mon, 2 Aug 2004 17:35:38 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Richard Williams <richard_williams@stratexnet.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Looking for fast flash programming code
Message-ID: <20040803003538.GA11101@gate.ebshome.net>
References: <A3240F62EF3C2749B1A25D3BC9548F4148BC20@ExchWENZ02.wenz.global.vpn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A3240F62EF3C2749B1A25D3BC9548F4148BC20@ExchWENZ02.wenz.global.vpn>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 03, 2004 at 09:13:40AM +1200, Richard Williams wrote:
>
> I am looking for fast flash programming code for AMD. Does this exist anywhere?
>
> In kernel 2.4.24, amd_flash.c only implements the slow programming algorithm.

IIRC, buffer write support for AMD chips is in MTD CVS.

--
Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
