Return-Path: <geoff@infradead.org>
Message-ID: <1393024759.5368.33.camel@smoke>
Subject: Re: [PATCH 2/9] ps3-vuart: don't use PREPARE_WORK
From: Geoff Levand <geoff@infradead.org>
To: Tejun Heo <tj@kernel.org>
Date: Fri, 21 Feb 2014 23:19:19 +0000
In-Reply-To: <1392929071-16555-3-git-send-email-tj@kernel.org>
References: <1392929071-16555-1-git-send-email-tj@kernel.org>
 <1392929071-16555-3-git-send-email-tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, 2014-02-20 at 15:44 -0500, Tejun Heo wrote:
> ps3_vuart wasn't overriding the work item with multiple work functions
> but was using NULL for INIT_WORK() and then single PREPARE_WORK() to
> set the work function.  We can simply invoke INIT_WORK() with the work
> function and remove the PREPARE_WORK() usage.
> 
> It would probably be best to route this with other related updates
> through the workqueue tree.

I tested this on ps3 (DECR-1400) and it seems to work OK.  Please queue
with your other workqueue changes.  Thanks!

Acked-by: Geoff Levand <geoff@infradead.org>
