Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Add program to convert dts files from v0 to v1 
In-reply-to: <20080515063912.GA30996@yookeroo.seuss> 
References: <20080515063912.GA30996@yookeroo.seuss>
Date: Mon, 19 May 2008 21:23:02 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JyHVG-00058U-CA@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch adds a new utility program, convert-dtsv0, to the dtc
> sources.  This program will convert dts files from v0 to v1,
> preserving comments and spacing.  It also includes some heuristics to
> guess an appropriate base to use in the v1 output (so it will use hex
> for the contents of reg properties and decimal for clock-frequency
> properties, for example).  They're limited and imperfect, but not
> terrible.
> 
> The guts of the converter program is a modified version of the lexer
> from dtc itself.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

For the record, I'd like to eventually retire this program
as well as support for /dts-v0/.

jdl
