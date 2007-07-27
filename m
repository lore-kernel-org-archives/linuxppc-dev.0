Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18090.33898.360087.492895@cargo.ozlabs.ibm.com>
Date: Sat, 28 Jul 2007 09:48:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Yoann Padioleau <padator@wanadoo.fr>
Subject: Re: [PATCH 12/68] 0 -> NULL, for arch/powerpc
In-Reply-To: <200707270945.LAA17267@ifs.emn.fr>
References: <200707270945.LAA17267@ifs.emn.fr>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yoann Padioleau writes:

> When comparing a pointer, it's clearer to compare it to NULL than to 0.

As other people have said, if you're going to spend time on this,
testing (!buf) is more idiomatic in the kernel than (buf == NULL).

Paul.
