Return-Path: <bpm@sgi.com>
Date: Wed, 21 Aug 2013 10:56:54 -0500
From: Ben Myers <bpm@sgi.com>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: linux-next: build failure after merge of the final tree
Message-ID: <20130821155654.GI5262@sgi.com>
References: <20130820172052.1f0d89ddf6a1a40ef70333fd@canb.auug.org.au>
 <20130820120702.000b044e@oracle.com>
 <201308202246.30869.arnd@arndb.de>
 <20130821010822.220f592a@oracle.com> <52145E6C.80404@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52145E6C.80404@ozlabs.org>
Cc: cbe-oss-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Dwight Engen <dwight.engen@oracle.com>,
 linux-kernel@vger.kernel.org, xfs@oss.sgi.com, linux-next@vger.kernel.org,
 Gao feng <gaofeng@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Dwight,

On Wed, Aug 21, 2013 at 02:30:04PM +0800, Jeremy Kerr wrote:
> > Yes, I agree. The other filesystems that take an Opt_uid as well do use
> > current_user_ns() and not init_user_ns. They also do a uid_valid()
> > check and fail the mount (or fallback to GLOBAL_ROOT_UID). So I think
> > that would look like this:
> 
> Looks good to me. Builds and mounts as expected.
> 
> Acked-by: Jeremy Kerr <jk@ozlabs.org>

Could you repost this patch with the right subject and a commit header?  Given
Jeremy's Ack I think we could proceed to pull this in.

Regards,
	Ben
