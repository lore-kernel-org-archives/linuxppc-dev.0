Date: Fri, 15 Feb 2002 08:58:12 -0800
From: Larry McVoy <lm@bitmover.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5 development
Message-ID: <20020215085812.Z8353@work.bitmover.com>
References: <15468.64269.8252.644104@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15468.64269.8252.644104@argo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Feb 15, 2002 at 11:11:57PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 15, 2002 at 11:11:57PM +1100, Paul Mackerras wrote:
> The current limitations of BK mean that we will not be able to take
> changesets directly from the linuxppc-2.5 tree and send them to
> Linus.

You can export changes as a patch and import them.  Notice that the new
"bk comments" command will let you change the comments after you do the
import.  To get a changeset's comments in a form that bk comments will
like, try this (requires bk 2.1.4 or later):

bk changes -r+ -vnd'### Change the comments to :GFILE: below\n:C:'

That will do it for the most recent changeset, s/+/rev/ that you used
with the export/import.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
