Date: Fri, 15 Feb 2002 10:32:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@bitmover.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5 development
Message-ID: <20020215173210.GM2004@opus.bloom.county>
References: <15468.64269.8252.644104@argo.ozlabs.ibm.com> <20020215085812.Z8353@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020215085812.Z8353@work.bitmover.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 15, 2002 at 08:58:12AM -0800, Larry McVoy wrote:
>
> On Fri, Feb 15, 2002 at 11:11:57PM +1100, Paul Mackerras wrote:
> > The current limitations of BK mean that we will not be able to take
> > changesets directly from the linuxppc-2.5 tree and send them to
> > Linus.
>
> You can export changes as a patch and import them.

Which still isn't directly. :)  It will catch most of the problems, but
if you export a patch with new files from one tree, import into another
and pull back into the original, you have a file conflict, yes?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
