Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18644.11988.483526.64749@cargo.ozlabs.ibm.com>
Date: Fri, 19 Sep 2008 15:59:32 -0700
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: patchwork states and workflow
In-Reply-To: <DF68B2B7-AFFF-4C86-AC27-55FFE5025C43@kernel.crashing.org>
References: <DF68B2B7-AFFF-4C86-AC27-55FFE5025C43@kernel.crashing.org>
Cc: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> I've always been a bit confused about some of the states we can put a  
> patch in.  For example, what does 'archiving' a patch mean?

Archiving puts the patch away somewhere where it doesn't appear in the
normal pages and needs extra effort to get to, as I understand it.

> What's the difference between 'deferred' and 'rejected'?  Is 'Under  
> Review' useful?

Deferred usually means the patch depends on something else that isn't
upstream, such as patches that only apply against the RT tree.
Rejected means we just don't want to do what the patch does.

> My biggest question is how to manage the transition of 'Accepted' and  
> 'Awaiting Upstream' and having clear definitions of what we think  
> these mean.

I put patches into "awaiting upstream" when I put them in a bundle, so
it means that they have entered my QA process.  When they're in my
public tree, I put them into "accepted" state.

[BTW, DaveM, you don't appear to be explicitly cc'd, so I couldn't
explicitly remove you.  Presumably you are getting this thread through
the linuxppc-dev list.]

Paul.
