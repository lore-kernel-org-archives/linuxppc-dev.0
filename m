Return-Path: <paulus@ozlabs.org>
Date: Mon, 9 Sep 2013 15:33:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 05/12] powerpc/book3s: Introduce a early machine
 check hook in cpu_spec.
Message-ID: <20130909053350.GE6248@drongo>
References: <20130826192616.2855.18749.stgit@mars>
 <20130826193156.2855.85412.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130826193156.2855.85412.stgit@mars>
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

On Tue, Aug 27, 2013 at 01:01:56AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> This patch adds the early machine check function pointer in cputable for
> CPU specific early machine check handling. The early machine handle routine
> will be called in real mode to handle SLB and TLB errors. This patch just
> sets up a mechanism invoke CPU specific handler. The subsequent patches
> will populate the function pointer.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Your patch description should talk about how this new hook is
different from the existing machine_check hook and why you need a new
one.

Apart from that:

Acked-by: Paul Mackerras <paulus@samba.org>
