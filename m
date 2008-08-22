Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] New Patchwork beta
Date: Fri, 22 Aug 2008 16:55:42 +0800
References: <200808211822.27786.jk@ozlabs.org>
	<1219359163.26429.62.camel@jdub.homelinux.org>
	<255B3FE9-1938-4CC0-ACA6-E8B4302531AC@kernel.crashing.org>
In-Reply-To: <255B3FE9-1938-4CC0-ACA6-E8B4302531AC@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808221655.42958.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

[trimming CC list]

> Now that I can log in, can I get "maintainer" privileges (user:
> galak)

Yep, you should already have maintainer privs for linuxppc-dev

> also is it possible to put the patch controls in a separate frame so
> they are always visible (dont have to scoll to the bottom to find
> them).

I'm trying to avoid using frames; it makes it hard to link to individual 
pages, and makes patch updating much more complex.

However, there shouldn't be a need for too much scrolling now - to 
prevent patch lists from growing too long, the results are paginated 
into groups of 100 patches.

Also, when there are more than about 30 patches on a page, you'll get a 
small link on the left-hand side to scroll straight to the form area.

Is this OK?

Cheers,


Jeremy
