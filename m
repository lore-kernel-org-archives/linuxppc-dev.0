Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17235.33942.754076.419504@cargo.ozlabs.ibm.com>
Date: Mon, 17 Oct 2005 21:01:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <434BB09B.9070605@hogyros.de>
References: <17227.44943.714106.911471@cargo.ozlabs.ibm.com>
	<434BB09B.9070605@hogyros.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: merge progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Simon Richter writes:

> Should I fast-forward the APUS patches towards the merge tree, or is it 
> better to apply them in the unmerged tree and merge them back into the 
> merge tree from there?

Hmmm, probably should work off the merge tree.  However, we decided at
OLS that platforms would require a device tree before being merged.
Have you looked at creating a suitable flattened device tree blob with
dtc?  (If not, you can continue to compile with ARCH=ppc for now.)

Paul.
