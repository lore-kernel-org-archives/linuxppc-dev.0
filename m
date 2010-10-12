Return-Path: <geoff.levand@am.sony.com>
Message-ID: <4CB48643.6050900@am.sony.com>
Date: Tue, 12 Oct 2010 09:01:07 -0700
From: Geoff Levand <geoff.levand@am.sony.com>
MIME-Version: 1.0
To: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] ps3disk: passing wrong variable to bvec_kunmap_irq()
References: <20101011191335.GH5851@bicker>
In-Reply-To: <20101011191335.GH5851@bicker>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Geoff Levand <geoff@infradead.org>, Jens Axboe <jaxboe@fusionio.com>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/11/2010 12:13 PM, Dan Carpenter wrote:
> This should pass "buf" to bvec_kunmap_irq() instead of "bv".  The api is
> like kmap_atomic() instead of kmap().
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Looks good.  Thanks.

Acked-by: Geoff Levand <geoff@infradead.org>
