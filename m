Return-Path: <yong.zhang0@gmail.com>
Date: Mon, 25 Oct 2010 22:15:10 +0800
From: Yong Zhang <yong.zhang0@gmail.com>
To: divya <dipraksh@linux.vnet.ibm.com>
Subject: Re: BUG with the kernel version 2.6.36-rc1 on power machine
Message-ID: <20101025141510.GA5875@zhy>
References: <4CC13B2C.7090908@linux.vnet.ibm.com>
	<4CC13FFF.7040200@linux.vnet.ibm.com>
	<AANLkTikmpohofzO_dV_Dv8EfcEMsyy4cdhGMUD-PAFO3@mail.gmail.com>
	<1287774802.19497.1.camel@subratamodak.linux.ibm.com>
	<20101023093630.GA3036@zhy> <4CC563A9.3020308@linux.vnet.ibm.com>
	<20101025135710.GA5461@zhy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20101025135710.GA5461@zhy>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 25, 2010 at 09:57:10PM +0800, Yong Zhang wrote:
> On Mon, Oct 25, 2010 at 04:32:01PM +0530, divya wrote:
> > http://lkml.org/lkml/2010/10/13/67 resolves the issue.
> > 
> > But this is not a part of 2.6.36-git6 , when will it be pulled into the upstream?
> 
> That patch is splited into two parts.
> The lockdep one is 4ba053c04aece1f4734056f21b751eee47ea3fb1 upstream.
> The mousedev one is taken by Dmitry Torokhov(Cc'ing)

Just notice Dmitry has sent pull request to Linus.
You can also get the mousedev one here:
http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=f74eef95e33a07379aa2b950c7f313cbfd55ebbe

Thanks,
Yong
