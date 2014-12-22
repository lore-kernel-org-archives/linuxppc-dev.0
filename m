Return-Path: <michael@ozlabs.org>
In-Reply-To: <1419087601-4889-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: arch: powerpc: platforms: ps3: repository.c: Remove unused
 function
Message-Id: <20141222050223.39FA91400E7@ozlabs.org>
Date: Mon, 22 Dec 2014 16:02:23 +1100 (AEDT)
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-20-12 at 15:00:01 UTC, Rickard Strandqvist wrote:
> Remove the function ps3_repository_write_highmem_info() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.

Actually it looks like everything under CONFIG_PS3_REPOSITORY_WRITE is unused,
and never was used.

We appreciate these sort of patches, but if you can dig a little deeper and
also work out why the code is unused that would be much more useful.

cheers
