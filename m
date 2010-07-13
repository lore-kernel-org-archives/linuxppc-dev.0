Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 5B874B6F0E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 01:26:13 +1000 (EST)
Date: Tue, 13 Jul 2010 11:26:10 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: section .data..init_task
Message-ID: <20100713112610.30b66318@lappy.seanm.ca>
In-Reply-To: <20100713085419.GA5826@merkur.ravnborg.org>
References: <20100628005900.28d4a8e0@lappy.seanm.ca>
	<20100712203435.08a3e90f@lappy.seanm.ca>
	<20100713085419.GA5826@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Denys Vlasenko <vda.linux@googlemail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Tim Abbott <tabbott@ksplice.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Jul 2010 10:54:19 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> It looks like a missing AT() in the output section.
> The following patch should also fix it.
> 
> Please test and let us know.
> 
> Thanks,
> 	Sam

Applied the patch and it solves the problem. Thanks.

Cheers,
   Sean
