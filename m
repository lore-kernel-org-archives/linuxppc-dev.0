Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id 47860B6F0E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 01:33:19 +1000 (EST)
Date: Tue, 13 Jul 2010 17:33:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: section .data..init_task
Message-ID: <20100713153315.GA11211@merkur.ravnborg.org>
References: <20100628005900.28d4a8e0@lappy.seanm.ca>
	<20100712203435.08a3e90f@lappy.seanm.ca>
	<20100713085419.GA5826@merkur.ravnborg.org>
	<20100713112610.30b66318@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100713112610.30b66318@lappy.seanm.ca>
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

On Tue, Jul 13, 2010 at 11:26:10AM -0400, Sean MacLennan wrote:
> On Tue, 13 Jul 2010 10:54:19 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > It looks like a missing AT() in the output section.
> > The following patch should also fix it.
> > 
> > Please test and let us know.
> > 
> > Thanks,
> > 	Sam
> 
> Applied the patch and it solves the problem. Thanks.

Thanks for the quick feedback!

	Sam
