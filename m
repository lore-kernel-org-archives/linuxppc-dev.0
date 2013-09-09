Return-Path: <paulus@ozlabs.org>
Date: Mon, 9 Sep 2013 14:30:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 02/12] powerpc/book3s: Introduce exclusive
 emergency stack for machine check exception.
Message-ID: <20130909043016.GB6248@drongo>
References: <20130826192616.2855.18749.stgit@mars>
 <20130826193132.2855.85275.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130826193132.2855.85275.stgit@mars>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 27, 2013 at 01:01:32AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> This patch introduces exclusive emergency stack for machine check exception.
> We use emergency stack to handle machine check exception so that we can save
> MCE information (srr1, srr0, dar and dsisr) before turning on ME bit and be
> ready for re-entrancy. This helps us to prevent clobbering of MCE information
> in case of nested machine checks.
> 
> The reason for using emergency stack over normal kernel stack is that the
> machine check might occur in the middle of setting up a stack frame which may
> result into improper use of kernel stack.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
