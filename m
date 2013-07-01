Return-Path: <michael@ellerman.id.au>
Date: Mon, 1 Jul 2013 11:53:30 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Runzhen Wang <runzhen@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/2] perf tools: Power7 events name available for perf
Message-ID: <20130701015329.GA22928@concordia>
References: <1372407297-6996-1-git-send-email-runzhen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372407297-6996-1-git-send-email-runzhen@linux.vnet.ibm.com>
Cc: icycoder@gmail.com, linux-kernel@vger.kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, acme@redhat.com, paulus@samba.org,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, runzhew@clemson.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 28, 2013 at 04:14:55PM +0800, Runzhen Wang wrote:
> Thank for Sukadev Bhattip and Xiao Guangrong's help.
> Thank for Michael Ellerman's review. 
> 
> ChangeLog: v2 -> v3:
> 
> 1. Adding a leading zero to all the events code in "power7-events-list.h" 
>    which don't have a PMC, so that they all line up vertically.

Hi Runzhen,

These look good to me. Thanks for reworking them.

They seem to be on top of Arnaldo's tree, so it's probably easiest if he
takes them.

You can have my:

Acked-by: Michael Ellerman <michael@ellerman.id.au>


Arnaldo if you also want Benh's ack let us know and I'll pester him.

cheers
