Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16940.6949.757096.59594@cargo.ozlabs.ibm.com>
Date: Mon, 7 Mar 2005 20:13:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Joerg Dorchain <joerg@dorchain.net>
In-Reply-To: <20050307073721.GB15637@Redstar.dorchain.net>
References: <20050306222256.A3F911F1FF@trashy.coderock.org>
	<20050307073721.GB15637@Redstar.dorchain.net>
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org
Subject: Re: [patch 1/4] delete unused file arch_ppc_kernel_find_name.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joerg Dorchain writes:

> To me it looks more like a devloper aid than a kernel file. Ok, it
> functionality could be replaced by a grep -C, but really delete it?

Last time I looked, grep didn't have the ability to find a string that
isn't in the file.  The address you are searching for might be between
two addresses listed in System.map, in which case find_name.c will
print the symbol corresponding to the lower of the two addresses.  Not
that I use find_name.c myself.  I agree that arch/ppc/kernel is a bad
place for it too.

Paul.
