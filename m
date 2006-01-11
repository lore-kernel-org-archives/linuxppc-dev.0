Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <17348.37558.434652.697604@cargo.ozlabs.ibm.com>
References: <17348.35120.840409.283964@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0601102238530.15824-100000@gate.crashing.org>
	<17348.37558.434652.697604@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AE3F00FD-6A4C-4A21-9075-2F0FE8BCB83E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 11 Jan 2006 00:10:02 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, Kumar Gala <galak@gate.crashing.org>,
	sjmunroe@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] implement AT_PLATFORM for powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 10, 2006, at 11:08 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> We should probably add two new AT_PLATFORM: "ppc8548" and "ppc5554".
>> "ppc8548" should be used for e500v2, and "ppc5554" for "e200z6".
>
> How different are they in user-level ISA or in instruction scheduling
> requirements?

8548 adds embedded double precision instructions.  e200/e500 are  
hugely different from a scheduling point of view.

>> You aren't seeting PPC_FEATURE_BOOKE for anything.  We need to be  
>> a little
>> careful since 'isel' isn't implemented in the very first 440's.
>
> Oops, I must have sent the wrong version of the patch.  Do we know
> which 440s have or don't have isel?

Not 100% sure, hopefully Matt Porter or someone else a bit more  
familiar with the 440's will chime in.

- k
