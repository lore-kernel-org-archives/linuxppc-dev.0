Return-Path: <paulus@ozlabs.org>
Date: Fri, 16 Nov 2012 22:42:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc, perf: Change PMU flag values representation
 from decimal to hex
Message-ID: <20121116114219.GA5745@bloggs.ozlabs.ibm.com>
References: <1353056344-1392-1-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353056344-1392-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: michael.neuling@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 16, 2012 at 02:29:04PM +0530, Anshuman Khandual wrote:
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

That's not a sufficient description of why you are making this
change.  In particular, what is the motivation for and impact of using
LONG_ASM_CONST?

Paul.
