Return-Path: <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 20:26:31 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/perf: Power8 PMU support
Message-ID: <20130415102630.GA2478@concordia>
References: <1365999438-20578-1-git-send-email-michael@ellerman.id.au>
 <1366011086.24994.33.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366011086.24994.33.camel@pasglop>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 15, 2013 at 09:31:26AM +0200, Benjamin Herrenschmidt wrote:
> On Mon, 2013-04-15 at 14:17 +1000, Michael Ellerman wrote:
> > This patch adds preliminary support for the power8 PMU to perf.
> 
> Might be worthwhile to have a small blurb explaining roughly what you
> mean by "preliminary" :-)

True.

There's no alternative handling, and no cache events. I need to work
with the HW folks on both of those.

Also missing is EBB support. I will hopefully post that in the next few
days.

cheers
