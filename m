Message-ID: <383AC4C4.6168406@schweiz.ch>
Date: Tue, 23 Nov 1999 17:45:56 +0100
From: Andreas Tobler <a.tobler@schweiz.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Stephane GEORGES <sg@dalim.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: R_PPC_REL24 relocation out of range
References: <A5D247E9DC04C08EC1256832004AFECD.004AFF0FC1256832@kehl.dalim.de> <383AC15A.1D5EAFE2@dalim.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Stephane GEORGES wrote:
> 
> Andreas Tobler wrote:
> 
> > Which version of binutils are you working with? Maybe a newer version
> > helps?
> > http://dev.linuxppc.org/pub/users/fsirl/R5/RPMS/ppc/binutils-2.9.5.0.14-0a.
> > ppc.rpm
> 
> I downloaded the binutils-2.9.5.0.14-0a
> NOW, most of my plugins are dlopen'ed correctly. But there are still some
> of them with which I have the same error message.
> 
> I tried the command
> 
> ldd -r ..../plugin.so.1.0 and they do not seem to have unresolved symbol.
> 
> What do you think it is ?

I'm guessing, what about a glibc / compiler update? Same place above.
Or the latest binutils from ftp.valinux.com/pub/hjl/binutils/?

I really don't know....

Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
-----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
