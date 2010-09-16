Return-Path: <peterz@infradead.org>
Subject: Re: 2.6.35-stable/ppc64/p7: suspicious rcu_dereference_check()
	usage detected during 2.6.35-stable boot
From: Peter Zijlstra <peterz@infradead.org>
To: Valdis.Kletnieks@vt.edu
In-Reply-To: <10430.1284649951@localhost>
References: <1280739132.15317.9.camel@subratamodak.linux.ibm.com>
	<20100809161200.GC3026@linux.vnet.ibm.com> <10430.1284649951@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Sep 2010 17:50:48 +0200
Message-ID: <1284652248.2275.570.camel@laptop>
Mime-Version: 1.0
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Li Zefan <lizf@cn.fujitsu.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>, paulmck@linux.vnet.ibm.com,
	Subrata Modak <subrata@linux.vnet.ibm.com>,
	DIVYA PRAKASH <dipraksh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-16 at 11:12 -0400, Valdis.Kletnieks@vt.edu wrote:
>=20
> Ping?  I just hit it on 2.6.36-rc4-mmotm0915.  Just wanted to make sure t=
he
> issue hadn't been lost/forgotten.=20

lost,.. thanks!
