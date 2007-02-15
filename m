Return-Path: <acmay@acmay.homeip.net>
Received: from fed1rmmtao106.cox.net (fed1rmmtao106.cox.net [68.230.241.40])
	by ozlabs.org (Postfix) with ESMTP id 46C77DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 14:51:46 +1100 (EST)
Date: Wed, 14 Feb 2007 19:16:29 -0800
From: Andrew May <acmay@acmay.homeip.net>
To: Daniel Ng <daniel_ng11@lycos.com>
Message-ID: <20070214191629.7e750923@localhost.localdomain>
In-Reply-To: <loom.20070215T000853-313@post.gmane.org>
References: <loom.20070214T072955-792@post.gmane.org>
	<97C76137-FF67-4145-BAF3-1AB3290F4D05@emi.yamaha.co.jp>
	<loom.20070215T000853-313@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: 'make' behaviour in BuildRoot
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 14 Feb 2007 23:09:31 +0000 (UTC)
Daniel Ng <daniel_ng11@lycos.com> wrote:

> Surely I should just be able to type 'make' which would result in the
> tree structure updated in the cramfs image? Any ideas? Where are the
> BuildRoot experts out there? Can someone tell me how to subscribe to
> the BuildRoot list?
> 

The html docs are online, and they should be under buildroot/docs/

http://buildroot.uclibc.org/buildroot.html#custom_targetfs

You may just want option 1, for now. It sounds like you jumped to #2.

Or you can write a new rule for your test23 program.
http://buildroot.uclibc.org/buildroot.html#add_software

Or you can use this rule/config option
http://buildroot.uclibc.org/cgi-bin/viewcvs.cgi/trunk/buildroot/package/customize/Config.in?rev=9614&view=auto

And the list info is here.
http://buildroot.uclibc.org/lists.html
