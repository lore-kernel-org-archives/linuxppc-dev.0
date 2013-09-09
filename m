Return-Path: <paulus@ozlabs.org>
Date: Mon, 9 Sep 2013 14:29:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 01/12] powerpc/book3s: Split the common exception
 prolog logic into two section.
Message-ID: <20130909042902.GA6248@drongo>
References: <20130826192616.2855.18749.stgit@mars>
 <20130826193124.2855.96419.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130826193124.2855.96419.stgit@mars>
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

On Tue, Aug 27, 2013 at 01:01:24AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> This patch splits the common exception prolog logic into two parts to
> facilitate reuse of existing code in the next patch. The second part will
> be reused in the machine check exception routine in the next patch.
> 
> Please note that this patch does not introduce or change existing code
> logic. Instead it is just a code movement.

Looks OK.  Note however that the diff would be a lot smaller if you
had put EXCEPTION_PROLOG_COMMON_2 after EXCEPTION_PROLOG_COMMON instead
of before it.

Acked-by: Paul Mackerras <paulus@samba.org>
