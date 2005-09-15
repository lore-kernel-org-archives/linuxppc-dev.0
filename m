Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17193.22650.615956.743651@cargo.ozlabs.ibm.com>
Date: Thu, 15 Sep 2005 21:18:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050913175028.GB14889@dmt.cnet>
References: <20050913175028.GB14889@dmt.cnet>
Cc: linuxppc-dev@ozlabs.org, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: __switch_to test-and-branch ALTIVEC specific?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti writes:

> This test&branch looks AltiVec specific, any reason for not #ifdef'ing it
> out?

No, your patch looks fine.  (/me wishes patchwork had a "Queued"
state.)

Paul.
