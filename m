Return-Path: <dgibson@ozlabs.org>
Date: Thu, 29 May 2008 09:58:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Add support for binary includes.
Message-ID: <20080528235859.GA10260@yookeroo.seuss>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080226003955.GA24382@localhost.localdomain>
	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
	<483C4C04.9020408@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <483C4C04.9020408@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 27, 2008 at 12:59:32PM -0500, Jon Loeliger wrote:
> Kumar Gala wrote:
>>
>> On Feb 25, 2008, at 6:39 PM, David Gibson wrote:
>>
>>> On Wed, Feb 20, 2008 at 01:19:41PM -0600, Scott Wood wrote:
>>>> A property's data can be populated with a file's contents
>>>> as follows:
>>>>
>>>> node {
>>>>     prop = /incbin/("path/to/data");
>>>> };
>>>>
>>>> A subset of a file can be included by passing start and size parameters.
>>>> For example, to include bytes 8 through 23:
>>>>
>>>> node {
>>>>     prop = /incbin/("path/to/data", 8, 16);
>>>> };
>>>>
>>>> As with /include/, non-absolute paths are looked for in the directory
>>>> of the source file that includes them.
>
> That issue was resolved, I believe.
>
>>> Well, while I discuss the syntax with Jon, here's some comments on the
>>> implementation.
>>
>> have we made any progress on the syntax?
>
> My last suggestions garnered a "I like that even less." response,
> so as far as I know, we're still waiting for a good proposal here.

A while back I sent out a spiel explaining more clearly why I didn't
like it, and where I thought we should go with this, but I don't think
anyone noticed it at the time.  I'll resend.

I started working towards a version of this I liked, but was
sidetracked by a combination of my own other work, and the fact that
Jon's been busy meaning there's a rather large lag on merging dtc
patches.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
