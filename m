Return-Path: <hollisb@us.ibm.com>
Subject: Re: update: consolidated flat device tree code
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17643.64011.666743.300278@cargo.ozlabs.ibm.com>
References: <1155860626.27466.126.camel@basalt.austin.ibm.com>
	<17643.64011.666743.300278@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 09:42:58 -0500
Message-Id: <1156344179.7960.4.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Pantelis Antoniou <pantelis@embeddedalley.com>,
	"Sachin P. Sant" <sachinp@in.ibm.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-23 at 16:47 +1000, Paul Mackerras wrote:
> Hollis Blanchard writes:
> 
> > Still haven't looked to merge Matt's changes (because I'm busy, the
> > current code works for me, and they haven't been accepted in u-boot
> > yet).
> 
> The other version that was posted had support for modifying an
> existing flat tree, which I need for the wrapper code for prep.  Are
> those "Matt's changes"?  Are you thinking of adding that capability to
> your version?

You can do this now with the ft_set_prop() function, which is what I'm
using for Xen.

At the moment that function isn't able to modify the size of a property,
but Mark is going to adapt his code (which supports that).

-- 
Hollis Blanchard
IBM Linux Technology Center
