Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050826190403.GA6265@austin.ibm.com>
References: <20050826190403.GA6265@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <28F4C8E9-FF41-4954-977D-546732D561B8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 26 Aug 2005 14:07:37 -0500
To: "Olof Johansson" <olof@lixom.net>
Cc: Andrew Morton <akpm@osdl.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc64: Add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What were you building for?  I'm wondering if the same issue exists  
that you are asked, but its not wired to actually do anything.

- kumar

On Aug 26, 2005, at 2:04 PM, Olof Johansson wrote:

> On Fri, Aug 26, 2005 at 02:00:43PM -0500, Kumar Gala wrote:
>
>> Any reason we shouldn't do the same thing on ppc32?
>>
>
> When I built a 2.6.13-rc7 I got the question about what HZ I wanted,
> so I guess we're already doing it. Maybe the default needs changing
> though, can't remember what it was.
>
>
> -Olof
>
