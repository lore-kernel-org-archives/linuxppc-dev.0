Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <17235.33942.754076.419504@cargo.ozlabs.ibm.com>
References: <17227.44943.714106.911471@cargo.ozlabs.ibm.com>
	<434BB09B.9070605@hogyros.de>
	<17235.33942.754076.419504@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BB7D0947-E876-4C5F-ABE7-DA5A4C92EEF0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 17 Oct 2005 17:39:02 -0500
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: merge progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hmmm, probably should work off the merge tree.  However, we decided at
> OLS that platforms would require a device tree before being merged.
> Have you looked at creating a suitable flattened device tree blob with
> dtc?  (If not, you can continue to compile with ARCH=ppc for now.)

That would assume the ARCH=ppc builds in the merge tree.  Paul, stop  
breaking ARCH=ppc just because your annoyed at me for killing 970 and  
POWER4 in the cputable :)

syscalls has issues in ARCH=ppc.

- kumar
