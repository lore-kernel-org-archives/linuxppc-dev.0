Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18086.41665.610756.139183@cargo.ozlabs.ibm.com>
Date: Wed, 25 Jul 2007 11:09:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [patch 1/3] ps3: Disk Storage Driver
In-Reply-To: <46A5E610.7000508@shadowen.org>
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.392129000@pademelon.sonytel.be>
	<20070718163637.3f0e0164.akpm@linux-foundation.org>
	<46A5E610.7000508@shadowen.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Jens Axboe <jens.axboe@oracle.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Whitcroft writes:

> Ok, this is something we need to decide on.  Currently we only ask for
> consistent spacing on all the mathematic operators.  This is mostly as
> we do see a large number of non-spaced uses in defines and the like.
> 
> I am happy to expand these tests so they are always spaced on both sides
> style if that is the preference.

It depends very much on the context - on the precedence and relative
importance of one operator with respect to other operators and the
statement as a whole.  In general I prefer spaces around binary
operators, but there are situations where not putting spaces around
some operators can enhance the readability of the statement as a
whole.

If checkpatch.pl starts whinging about operators without spaces that
will just be yet another reason not to use it IMHO.

Also, I prefer the style where the ? and : operators have a space
after them but not before them, rather than a space either side.

Paul.
