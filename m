Return-Path: <benh@kernel.crashing.org>
Subject: Re: patchwork states and workflow
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18644.11988.483526.64749@cargo.ozlabs.ibm.com>
References: <DF68B2B7-AFFF-4C86-AC27-55FFE5025C43@kernel.crashing.org>
	<18644.11988.483526.64749@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 19 Sep 2008 16:30:57 -0700
Message-Id: <1221867057.12085.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jeremy Kerr <jk@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-09-19 at 15:59 -0700, Paul Mackerras wrote:
> Kumar Gala writes:
> 
> > I've always been a bit confused about some of the states we can put a  
> > patch in.  For example, what does 'archiving' a patch mean?
> 
> Archiving puts the patch away somewhere where it doesn't appear in the
> normal pages and needs extra effort to get to, as I understand it.
> 
> > What's the difference between 'deferred' and 'rejected'?  Is 'Under  
> > Review' useful?
> 
> Deferred usually means the patch depends on something else that isn't
> upstream, such as patches that only apply against the RT tree.
> Rejected means we just don't want to do what the patch does.
> 
> > My biggest question is how to manage the transition of 'Accepted' and  
> > 'Awaiting Upstream' and having clear definitions of what we think  
> > these mean.
> 
> I put patches into "awaiting upstream" when I put them in a bundle, so
> it means that they have entered my QA process.  When they're in my
> public tree, I put them into "accepted" state.

Note, Kumar, that I have a git hook that will generate a file that
lists the sha1 and corresponding patchwork IDs when you use git-am.

I can send that to you when I'm back.

You can then use a little tool that automatically update patchwork based
on that file, filing the SHA1 reference in the database and switching
the patches to "accepted" state.

Ben.
