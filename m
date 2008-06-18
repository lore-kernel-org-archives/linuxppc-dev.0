Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18521.37627.275223.34489@cargo.ozlabs.ibm.com>
Date: Thu, 19 Jun 2008 08:58:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX
In-Reply-To: <7B118E94-F308-4768-8ED6-BD66C5C3D3CA@kernel.crashing.org>
References: <20080618004734.0B72E70296@localhost.localdomain>
	<7B118E94-F308-4768-8ED6-BD66C5C3D3CA@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Is VSX mutually exclusive with altivec/fp?  is there a MSR bit for it?

It's not exclusive, it's an extension of altivec/fp, and yes it has
its own MSR bit to enable it.

Paul.
