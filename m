Return-Path: <mpe@ellerman.id.au>
Message-ID: <1387331962.19507.4.camel@concordia>
Subject: Re: [PATCH 1/2] power7, perf: Make some new raw event codes
 available in sysfs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 18 Dec 2013 12:59:22 +1100
In-Reply-To: <52AA8D4C.6040905@linux.vnet.ibm.com>
References: <1381902780-2719-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1381902780-2719-2-git-send-email-khandual@linux.vnet.ibm.com>
 <1386903031.3853.2.camel@concordia> <52AA8D4C.6040905@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-12-13 at 10:00 +0530, Anshuman Khandual wrote:
> On 12/13/2013 08:20 AM, Michael Ellerman wrote:
> > On Wed, 2013-10-16 at 11:22 +0530, Anshuman Khandual wrote:
> >> This patch adds some more raw event codes into the existing list
> >> of event codes present in power7-events-list.h file. This tries
> >> to complete the list of events supported in Power7 and matches
> >> the raw event list with libpfm4 library.
> > 
> > It's a bit annoying, but you also need to update the "ABI" document:
> 
> What is annoying ? you need to be specific.

It's annoying that we have to update the ABI document.

> >   Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> > 
> 
> The events listed under the following heading are events required to do
> CPI analysis.

No they are not, it doesn't say that anywhere in the file.

It happens that the events in there *now* are the CPI events, but that's because
they are the only ones that have been added.

> "Description:    POWER-systems specific performance monitoring event"
> 
> 		  /sys/devices/cpu/events/PM_1PLUS_PPC_CMPL
>                 /sys/devices/cpu/events/PM_BRU_FIN
>                 /sys/devices/cpu/events/PM_BR_MPRED
>                 /sys/devices/cpu/events/PM_CMPLU_STALL

All events that appear in /sys/devices/cpu/events on powerpc should be listed
in the file.

cheers
