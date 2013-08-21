Return-Path: <jk@ozlabs.org>
Message-ID: <52145E6C.80404@ozlabs.org>
Date: Wed, 21 Aug 2013 14:30:04 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Dwight Engen <dwight.engen@oracle.com>
Subject: Re: linux-next: build failure after merge of the final tree
References: <20130820172052.1f0d89ddf6a1a40ef70333fd@canb.auug.org.au>
 <20130820120702.000b044e@oracle.com> <201308202246.30869.arnd@arndb.de>
 <20130821010822.220f592a@oracle.com>
In-Reply-To: <20130821010822.220f592a@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, xfs@oss.sgi.com,
 Ben Myers <bpm@sgi.com>, linux-next@vger.kernel.org,
 Gao feng <gaofeng@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

> Yes, I agree. The other filesystems that take an Opt_uid as well do use
> current_user_ns() and not init_user_ns. They also do a uid_valid()
> check and fail the mount (or fallback to GLOBAL_ROOT_UID). So I think
> that would look like this:

Looks good to me. Builds and mounts as expected.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
