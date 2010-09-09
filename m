Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A315CB70D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 03:10:02 +1000 (EST)
Date: Thu, 9 Sep 2010 13:09:54 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: Combining defconfigs for 44x based boards
Message-ID: <20100909130954.265adb37@lappy.seanm.ca>
In-Reply-To: <56886bb653a2198b7a5bdcf5f38d4a98@mail.gmail.com>
References: <a3a9eb5a2e770f931950ad13c01960da@mail.gmail.com>
	<20100909004853.GA11808@zod.rchland.ibm.com>
	<49073d172310031addb3aa7d08a60c99@mail.gmail.com>
	<20100909063601.03CCE1506AA@gemini.denx.de>
	<56886bb653a2198b7a5bdcf5f38d4a98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 9 Sep 2010 09:49:14 -0700
Tirumala Marri <tmarri@apm.com> wrote:

> [Marri] Great we already have it. We should remove the defconfigs
> under 44x then ?

I'd rather we didn't. I thought Linus' beef was over the churn in the
defconfigs, not the fact that they exist. The 44x defconfigs change
very rarely.

Cheers,
   Sean
