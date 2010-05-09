Return-Path: <paulus@ozlabs.org>
Date: Mon, 10 May 2010 09:05:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 1/2] powerpc: cleanup APIs for cpu/thread/core
	mappings
Message-ID: <20100509230522.GA2993@brick.ozlabs.ibm.com>
References: <20100507113907.5035.9794.stgit@drishya.in.ibm.com>
	<20100507114842.5035.65177.stgit@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100507114842.5035.65177.stgit@drishya.in.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 07, 2010 at 05:18:42PM +0530, Vaidyanathan Srinivasan wrote:

> These APIs take logical cpu number as input
> Change cpu_first_thread_in_core() to cpu_leftmost_thread_sibling()
> Change cpu_last_thread_in_core() to cpu_rightmost_thread_sibling()
> 
> These APIs convert core number (index) to logical cpu/thread numbers
> Add cpu_first_thread_of_core(int core)
> Changed cpu_thread_to_core() to cpu_core_of_thread(int cpu)

Why make all these changes?  The end result doesn't seem any cleaner
or better than how it was before, and your patch description doesn't
give any reason for us to think "yes, we should make this change".
I assume you think this is a good change to make, so you need to
explain why it's a good idea and convince the rest of us.

Paul.
