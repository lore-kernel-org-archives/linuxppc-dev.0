Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Mar 2008 11:43:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTC Patch Catch Up
Message-ID: <20080324004339.GA29985@localhost.localdomain>
References: <E1JdPvk-0005mf-2k@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JdPvk-0005mf-2k@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 23, 2008 at 08:08:08AM -0500, Jon Loeliger wrote:
> Folks,
> 
> I've applied the following patches from Gibson,
> in this order, to the DTC and pushed it out
> to git.jdl.com:
> 
>     dtc: Fix error reporting in push_input_file()
>     dtc: Implement checks for the format of node and property names
>     dtc: Fix indentation of fixup_phandle_references
>     dtc: Strip redundant "name" properties
>     dtc: Test and fix conversion to/from old dtb versions
>     dtc: Use for_each_marker_of_type in asm_emit_data()
>     dtc: Make -I dtb mode use fill_fullpaths()
>     dtc: Make eval_literal() static
>     dtc: Assorted improvements to test harness
>     dtc: Testcases for input handling
>     dtc: Make dtc_open_file() die() if unable to open requested file
>     dtc: Remove ugly include stack abuse
>     dtc: Abolish asize field of struct data
>     dtc: Add some documentation for the dts formta
>     dtc: Cleanup \nnn and \xNN string escape handling
>     dtc: Change exit code for usage message

Hurrah :)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
