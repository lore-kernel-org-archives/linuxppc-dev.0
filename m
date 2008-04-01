Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18418.49494.457893.866627@cargo.ozlabs.ibm.com>
Date: Wed, 2 Apr 2008 10:12:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Bartlomiej Sieka <tur@semihalf.com>
Subject: Re: Please pull powerpc.git merge branch
In-Reply-To: <47ED6BE5.9060807@semihalf.com>
References: <18412.58902.189124.391104@cargo.ozlabs.ibm.com>
	<47ED6BE5.9060807@semihalf.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bartlomiej Sieka writes:

> What about http://patchwork.ozlabs.org/linuxppc/patch?id=17525 ? I don't
> see it in the merge branch of your repository, and it would be nice to
> get it upstream as it fixes boot problems on some MPC5200-based boards.

It needs a proper stand-alone commit message and an acked-by from
Grant.  The commit message should explain why you are making the
changes you are making rather than just saying "the bulk of this patch
is taken from http://...".

Paul.
