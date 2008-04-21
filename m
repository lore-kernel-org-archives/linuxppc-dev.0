Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18444.33867.747492.180348@cargo.ozlabs.ibm.com>
Date: Mon, 21 Apr 2008 22:10:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: x86-latest/powerpc-next merge conflict
In-Reply-To: <20080421095102.GB1666@elte.hu>
References: <20080421191231.41a34aef.sfr@canb.auug.org.au>
	<20080421095102.GB1666@elte.hu>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar writes:

> Paul, do you agree with those generic bitops changes? Just in case it's 

Well, it looks OK, but I'm sure people are going to get confused with
fls vs. fls64 vs. __fls all being subtly different.  I'd say it's
worth putting a little file in the Documentation directory to explain
it all.

> not obvious from previous discussions: we'll push them upstream via a 
> separate pull request, not via usual x86.git changes. They originated 
> from x86.git but grew into a more generic improvement for all. They sit 
> in x86.git for tester convenience but are of course not pure x86 changes 
> anymore.

I'm not sure why the "add __fls to all 64-bit architectures" change
has to be done as a single patch rather than a patch per architecture
going through the architecture maintainers.  I suppose that avoids any
problem with some maintainers not sending it upstream quickly.  I
would expect that if it is a single cross-architecture patch that it
would go through Andrew Morton, though.  But if Andrew wants you to
handle it then I'm happy to give you an Acked-by for it.

Regards,
Paul.
