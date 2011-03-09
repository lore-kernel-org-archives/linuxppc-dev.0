Return-Path: <SRS0=7pvk=WC=start.ca=wilsons@srs.perfora.net>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.195])
	by ozlabs.org (Postfix) with ESMTP id C1D13B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 01:15:40 +1100 (EST)
Date: Wed, 9 Mar 2011 09:14:41 -0500
From: Stephen Wilson <wilsons@start.ca>
To: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH 0/5] make *_gate_vma accept mm_struct instead of
	task_struct
Message-ID: <20110309141441.GA8861@fibrous.localdomain>
References: <1299630721-4337-1-git-send-email-wilsons@start.ca>
	<AANLkTikTEi8uKeCfPLoenNx9g6fLyAqNqfVdR=4KzNB3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikTEi8uKeCfPLoenNx9g6fLyAqNqfVdR=4KzNB3@mail.gmail.com>
Cc: linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2011 at 05:09:09AM -0800, Michel Lespinasse wrote:
> On Tue, Mar 8, 2011 at 4:31 PM, Stephen Wilson <wilsons@start.ca> wrote:
> > Morally, the question of whether an address lies in a gate vma should be asked
> > with respect to an mm, not a particular task.
> >
> > Practically, dropping the dependency on task_struct will help make current and
> > future operations on mm's more flexible and convenient.  In particular, it
> > allows some code paths to avoid the need to hold task_lock.
> 
> Reviewed-by: Michel Lespinasse <walken@google.com>
> 
> May I suggest ia32_compat instead of just compat for the flag name ?

Yes, sounds good to me.  Will change in the next iteration.

Thanks for the review!


> -- 
> Michel "Walken" Lespinasse
> A program is never fully debugged until the last user dies.


-- 
steve
