Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC5451A007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 10:32:09 +1100 (AEDT)
Received: by mail-pa0-x233.google.com with SMTP id uo6so91542761pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Feb 2016 15:32:09 -0800 (PST)
Date: Tue, 2 Feb 2016 10:31:54 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 kgdb-bugreport@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Fix kgdb on little endian ppc64le
Message-ID: <20160202103154.7fdaa748@cotter.ozlabs.ibm.com>
In-Reply-To: <56AF35C4.2050700@au1.ibm.com>
References: <20160201170325.4ec4324e@cotter.ozlabs.ibm.com>
 <56AF35C4.2050700@au1.ibm.com>
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

On Mon, 1 Feb 2016 21:39:00 +1100
Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:

> On 01/02/16 17:03, Balbir Singh wrote:
> > From: Balbir Singh <bsingharora@gmail.com>
> >
> > I spent some time trying to use kgdb and debugged my inability to
> > resume from kgdb_handle_breakpoint(). NIP is not incremented
> > and that leads to a loop in the debugger.
> >
> > I've tested this lightly on a virtual instance with KDB enabled.
> > After the patch, I am able to get the "go" command to work as
> > expected
> >
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>  
> 
> Should this be Cc'd to stable?
> 
> 

Good suggestion, Michael? I can repost this to stable if required?

Balbir Singh.
