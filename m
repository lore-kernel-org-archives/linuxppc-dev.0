Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402gFW15kbzDqxx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 20:31:26 +1100 (AEDT)
Date: Fri, 16 Mar 2018 10:31:21 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>, "Bryant G. Ly"
 <bryantly@linux.vnet.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>, Nicholas
 Piggin <npiggin@gmail.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 linux-kernel@vger.kernel.org, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Joe Perches <joe@perches.com>, Oliver O'Halloran
 <oohall@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH RFC rebase 0/9] powerpc barrier_nospec
Message-ID: <20180316103121.6dadf5b2@naga.suse.cz>
In-Reply-To: <20180316080810.GA29615@kroah.com>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
 <20180316080810.GA29615@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Mar 2018 09:08:10 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Mar 15, 2018 at 08:15:49PM +0100, Michal Suchanek wrote:
> > Yes, it is good idea to add some commit messages.  
> 
> Always a good idea :)
> 
> Also, any reason you are not tagging these for the stable release(s)?

Oh, right. cc:stable would be a good idea as well.

Thanks

Michal
