Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18403.31456.932192.862554@cargo.ozlabs.ibm.com>
Date: Fri, 21 Mar 2008 20:07:44 +1100
From: Paul Mackerras <paulus@samba.org>
To: skumar@linux.vnet.ibm.com
Subject: Re: [BUG]2.6.25-rc6:Unable to handle kernel paging request
In-Reply-To: <20080320184216.GB32259@in.ibm.com>
References: <20080318052921.GA32259@in.ibm.com>
	<18400.36670.5918.566965@cargo.ozlabs.ibm.com>
	<20080320184216.GB32259@in.ibm.com>
Cc: Poornima Nayak <Poornima.Nayak@in.ibm.com>, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sudhir Kumar writes:

> > I suggest you turn off CONFIG_SENSORS_F71805F.
> It was a new feature so I turned it on while compiling.
> I have tried by turning off CONFIG_SENSORS_F71805F but the bug
> is still present.

Do you mean that you still saw a crash in f71805f_find?  If so, then
you have some problem with the way you rebuilt the kernel, or you
didn't boot the kernel you thought you did, or possibly that
CONFIG_SENSORS_F71805F is getting turned back on by a select statement
somewhere in some Kconfig file.

If you really turned CONFIG_SENSORS_F71805F off then there would be no
f71805f_find function in the kernel.

Paul.
