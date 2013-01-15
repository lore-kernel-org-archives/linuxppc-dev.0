Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.19.201])
 by ozlabs.org (Postfix) with ESMTP id 621622C0089
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2013 09:54:11 +1100 (EST)
Date: Tue, 15 Jan 2013 14:47:18 -0800
From: Greg KH <greg@kroah.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 6/6][v3] perf: Document the ABI of perf sysfs entries
Message-ID: <20130115224718.GC32544@kroah.com>
References: <20130110010347.GA32590@us.ibm.com>
 <20130110010703.GF32590@us.ibm.com>
 <20130115185759.GG5826@ghostprotocols.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130115185759.GG5826@ghostprotocols.net>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 robert.richter@amd.com, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2013 at 03:57:59PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 09, 2013 at 05:07:03PM -0800, Sukadev Bhattiprolu escreveu:
> > [PATCH 6/6][v3] perf: Document the ABI of perf sysfs entries
> > 
> > This patchset addes two new sets of files to sysfs:
> > 
> > 	- generic and POWER-specific perf events in /sys/devices/cpu/events/
> > 	- perf event config format in /sys/devices/cpu/format/event
> > 
> > Document the format of these files which would become part of the ABI.
> > 
> > Changelog[v3]:
> > 	[Greg KH] Include ABI documentation.
> 
> Jiri, can I have your ack on this one too?
> 
> Greg, all ok now?

No objection from me, thanks.

greg k-h
