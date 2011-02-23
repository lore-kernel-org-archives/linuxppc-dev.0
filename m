Return-Path: <anton@samba.org>
Date: Thu, 24 Feb 2011 09:11:21 +1100
From: Anton Blanchard <anton@samba.org>
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Subject: Re: mpc85xx: kexec build broken by "powerpc/kexec: Remove
	ppc_md.machine_kexec"
Message-ID: <20110224091121.43b31dad@kryten>
In-Reply-To: <B87A2622-0006-4FC8-893A-41DBBF0CA170@boeing.com>
References: <B87A2622-0006-4FC8-893A-41DBBF0CA170@boeing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Livingston, John A" <john.a.livingston@boeing.com>,
	Matthew McClintock <msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Kyle,

> As far as I can tell, "machine_kexec" was removed in commit c9486878
> (powerpc/kexec: Remove ppc_md.machine_kexec) on Jan 6th, 2011, which
> claims that it was not used.
> 
> Unfortunately it looks like it *is* used by the mpc85xx kexec()
> support (commit f933a41e), added on Jul 21, 2010.

Thanks for the report. Testing a patch now.

Anton
