Return-Path: <trini@kernel.crashing.org>
Date: Mon, 10 Jan 2005 12:12:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jerome Glisse <j.glisse@gmail.com>
Message-ID: <20050110191248.GB3391@smtp.west.cox.net>
References: <4240b916050109074053e328b1@mail.gmail.com>
	<16865.39960.274092.996530@cargo.ozlabs.ibm.com>
	<20050110145219.GB2226@smtp.west.cox.net>
	<4240b9160501101014317b8d85@mail.gmail.com>
	<20050110182940.GA3391@smtp.west.cox.net>
	<4240b91605011010593d2f3b3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4240b91605011010593d2f3b3d@mail.gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org
Subject: Re: Classic PPC specific ASM (CONFIG_6XX)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 10, 2005 at 07:59:50PM +0100, Jerome Glisse wrote:
> > I have a feeling CONFIG_6xx isn't selected for a good reason.  Can you
> > try, as a kludge, removing define_bool PPC_PREP from arch/ppc/Kconfig
> > and seeing if you can build / boot ?  Thanks.
> > 
> > --
> > Tom Rini
> > http://gate.crashing.org/~trini/
> > 
> 
> Seems that this flags is linked to many things :) I tried removing PPC_PREP
> bool but the kernel fail to compile with again new errors :
> 

One last thing before we just do what you suggested originally, can you
hack it so that PPC_PREP is still set, but on 970 we still set
CONFIG_6xx?  Thanks again.

-- 
Tom Rini
http://gate.crashing.org/~trini/
