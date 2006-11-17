Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8DB3A67BC4
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:11:47 +1100 (EST)
Date: Thu, 16 Nov 2006 17:11:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH]: HVCS char driver janitoring: fix compile warnings
Message-Id: <20061116171136.3eae31f9.akpm@osdl.org>
In-Reply-To: <20061117005540.GF23600@austin.ibm.com>
References: <20061115212619.GJ8395@austin.ibm.com>
	<1163635387.8805.7.camel@localhost.localdomain>
	<20061116203946.GA23600@austin.ibm.com>
	<1163716536.16815.5.camel@localhost.localdomain>
	<20061117005540.GF23600@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Alan Cox <alan@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 16 Nov 2006 18:55:40 -0600
linas@austin.ibm.com (Linas Vepstas) wrote:

> On Fri, Nov 17, 2006 at 09:35:36AM +1100, Michael Ellerman wrote:
> > 
> > Thanks, new patches look good.
> 
> Any clue who I should send these to? I think akpm took the earlier
> one,

I grabbed the new ones.  (and gave them vaguely conventional changelogs)

> I'm not clear if that means it will slosh into Linus' tree 
> eventually.

It does, unless something bad happens to them along the way.  But you'd hear
about it if that occurs.
