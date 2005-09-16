Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <17193.64509.576852.408757@cargo.ozlabs.ibm.com>
References: <17193.64509.576852.408757@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BC681339-998A-46A3-8728-30BA1A455ECF@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 15 Sep 2005 21:22:43 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: don't execute a temporary comment
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We are going to send this to Linus for 2.6.14, right?

- k

On Sep 15, 2005, at 5:55 PM, Paul Mackerras wrote:

> John W. Linville writes:
>
>
>> Why is this helpful?  Better in general to keep the commment near the
>>
> code, no?
>
> Where it was, it was a command, not a comment, so it got printed out
> on the screen when you did a make clean, which seemed a bit silly.
>
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
