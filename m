Return-Path: <imp@bsdimp.com>
Date: Thu, 10 Jun 2010 11:09:15 -0600 (MDT)
Message-Id: <20100610.110915.487329959621854233.imp@bsdimp.com>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <20100610165243.GA18043@oksana.dev.rtsoft.ru>
References: <20100610154741.GA7484@oksana.dev.rtsoft.ru>
	<20100610.100140.8559628065321695.imp@bsdimp.com>
	<20100610165243.GA18043@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, jeremy.kerr@canonical.com,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message: <20100610165243.GA18043@oksana.dev.rtsoft.ru>
            Anton Vorontsov <cbouatmailru@gmail.com> writes:
: On Thu, Jun 10, 2010 at 10:01:40AM -0600, M. Warner Losh wrote:
: [...]
: > But this requires extra, bogus fields in the structure
: 
: False. The [0] field isn't bogus, it has a defined meaning.
: It says: here is some amount of resouces may be allocated.

Not false: It is extra fields and extra lines of code.  The fact that
it is well defined doesn't make it any less bogus.  But again, that's
just opinion, much like your objection to the equally well defined
structure it replaces is bogus.

: > and creates a bogus sizeof issue.
: 
: Creates? False. The same sizeof problem exists in Grant's
: approach. sizeof(*dev) != what_we_have_allocated. Which is
: isn't great, I agree. And that's exactly why I proposed a
: dedicated allocation in the first place.

Your solution doesn't solve the sizeof issue.  Don't pretend it does.
Both ways allocate a random amount of memory larger than sizeof the
structure.

Warner
