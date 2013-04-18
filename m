Return-Path: <michael@ellerman.id.au>
Date: Thu, 18 Apr 2013 11:46:00 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH powerpc] make CONFIG_NUMA depends on CONFIG_SMP
Message-ID: <20130418014559.GB8261@concordia>
References: <1338370318.3637.12.camel@ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338370318.3637.12.camel@ThinkPad-T420>
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 30, 2012 at 05:31:58PM +0800, Li Zhong wrote:
> I'm not sure whether it makes sense to add this dependency to avoid
> CONFI_NUMA && !CONFIG_SMP. 
> 
> I want to do this because I saw some build errors on next-tree when
> compiling with CONFIG_SMP disabled, and it seems they are caused by some
> codes under the CONFIG_NUMA #ifdefs.  

This seems to make sense to me. Can you please repost with a better
changelog and a description of the actual build error you were seeing.

cheers
