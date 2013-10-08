Return-Path: <michael@ellerman.id.au>
Message-ID: <1381202935.25887.4.camel@concordia>
Subject: Re: [PATCH 5/9][v5] powerpc: implement is_instr_load_store().
From: Michael Ellerman <michael@ellerman.id.au>
To: Tom Musta <tommusta@gmail.com>
Date: Tue, 08 Oct 2013 14:28:55 +1100
In-Reply-To: <524DCAE6.5090601@gmail.com>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1380672911-12812-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <20131003053519.GC17237@concordia> <20131003190325.GB21561@us.ibm.com>
 <524DCAE6.5090601@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-03 at 14:52 -0500, Tom Musta wrote:
> On 10/3/2013 2:03 PM, Sukadev Bhattiprolu wrote:
> > Michael Ellerman [michael@ellerman.id.au] wrote:
> <snip>
> > |
> > |         if (lower == 6)
> > |             if (upper <= 1)
> > |                 return true;
> > |             return false;
> > v

> Note that this case covers the lvsl/lvsr instructions, which, despite their
> names are not actually loads.  So you could eliminate this check and do
> just a little bit better.

Yes you're right Tom, thanks for checking.

I saw "Load" in the name and that was good enough for me :)

cheers
