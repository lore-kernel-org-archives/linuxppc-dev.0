Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16865.39960.274092.996530@cargo.ozlabs.ibm.com>
Date: Mon, 10 Jan 2005 08:03:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jerome Glisse <j.glisse@gmail.com>
In-Reply-To: <4240b916050109074053e328b1@mail.gmail.com>
References: <4240b916050109074053e328b1@mail.gmail.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: Classic PPC specific ASM (CONFIG_6XX)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerome Glisse writes:

> With 2.6.10 i get a compilation error with disable_6xx_mmu

What kind of machine is this?  Could you send me your .config?

I suspect that maybe we aren't defining CONFIG_6XX for PPC970
machines.

Paul.
