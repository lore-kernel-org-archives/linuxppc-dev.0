Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E411BB7D85
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 22:50:46 +1000 (EST)
Subject: Re: [PATCH 3/3] powerpc/kexec: Add support for FSL-BookE
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100507121638.GQ2671@hansolo.jdub.homelinux.org>
Date: Fri, 7 May 2010 07:50:24 -0500
Message-Id: <6FE2C01E-1F9D-4742-B516-7333865C9200@kernel.crashing.org>
References: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
	<1270412343-19334-4-git-send-email-sebastian@breakpoint.cc>
	<42CE8E3E-E536-402C-970B-C4BBC036BEB9@kernel.crashing.org>
	<20100507072451.GA28507@Chamillionaire.breakpoint.cc>
	<y2me997b7421005070435ma23a4153m48545d4dd88db7c9@mail.gmail.com>
	<20100507121638.GQ2671@hansolo.jdub.homelinux.org>
To: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	"wilbur.chan" <wilbur512@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 7, 2010, at 7:16 AM, Josh Boyer wrote:

> On Fri, May 07, 2010 at 07:35:34PM +0800, wilbur.chan wrote:
>> Most booke powerpc are based on SMP, I am looking forward someone to
>> implement this. hiahia
>=20
> Erm, actually most Book-E powerpc CPUs are not SMP.  SMP Book-E cores =
are only
> a fairly recent development, and if I recall correctly you need an =
e500mc core
> to really have it work properly.

e500v2 also does SMP.  MPC8572, P2020, P102x are all e500v2 SMP :)

- k=
