Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 6/6] powerpc/powernv: Add support for POWER8 split core on
 powernv
In-reply-to: <CACPK8Xc6RqXCSR0BvHT=jZbUcWEEYZ50n4r1vQkUyu=NPfpFew@mail.gmail.com>
References: <1398303165-6576-1-git-send-email-mikey@neuling.org>
 <1398303165-6576-7-git-send-email-mikey@neuling.org>
 <CACPK8Xc6RqXCSR0BvHT=jZbUcWEEYZ50n4r1vQkUyu=NPfpFew@mail.gmail.com>
Date: Thu, 24 Apr 2014 14:06:13 +1000
Message-ID: <17402.1398312373@ale.ozlabs.ibm.com>
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joel Stanley <joel@jms.id.au> wrote:

> Hi Mikey,
> 
> On Thu, Apr 24, 2014 at 11:02 AM, Michael Neuling <mikey@neuling.org> wrote:
> > +static DEVICE_ATTR(subcores_per_core, 0600,
> > +               show_subcores_per_core, store_subcores_per_core);
> 
> Can we make this 644, so users can query the state of the system
> without being root? This is useful for tools like ppc64_cpu --info.

Good point... I'll update.

Thanks,
Mikey
