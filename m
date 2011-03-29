Return-Path: <matt@ozlabs.org>
Message-ID: <4D914123.2060801@ozlabs.org>
Date: Tue, 29 Mar 2011 13:17:07 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH 0/5] Make xHCI driver endian-safe, add a barrier, some
	debug
References: <4D8C47B0.1050104@ozlabs.org> <20110328221605.GB8065@xanatos>
In-Reply-To: <20110328221605.GB8065@xanatos>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/03/11 09:16, Sarah Sharp wrote:
> On Fri, Mar 25, 2011 at 06:43:44PM +1100, Matt Evans wrote:
>> Hi Sarah,
>>
>>
>> This series addresses the endian issues with the xHCI driver, and has brought
>> lovely USB 3 to PPC. :-)  I've tested various types of traffic on ppc4xx and
>> POWER7 and (some sound driver bugs notwithstanding) all seems fine.  Also
>> addresses an ordering problem we found and the recursive nature of the event
>> handling, plus the addition of some debug.
> 
> Thanks for doing this work, Matt!  I appreciate it.

Hey, no worries!  I've got some $3 USB speakers I wanted to connect to the
$15,000 POWER server, you know how it goes.

>> This should apply to 2.6.38/Linus' tree.
> 
> You say that these apply against 2.6.38, but recently a lot of xHCI
> changes went into Linus' tree to support USB 3.0 hubs in 2.6.39.  Will
> these patches still apply against Linus' latest tree?  If not, I suggest
> you base your patches against Greg KH's usb-linus branch, as that's my
> tree base:
> 
> http://git.kernel.org/?p=linux/kernel/git/gregkh/usb-2.6.git;a=shortlog;h=refs/heads/usb-linus

Sorry, I wasn't too explicit about that; I'd meant "Linus' tree as of todayish"
and I believe I caught said USB 3.0 changes, but I'll rebase from usb-linus
anyway to make sure we're fine.

> Also, I haven't read too far into the patches, but the first patch seems
> to have several one or two letter variable names, like "f" and "di".
> Can you make those variable names more descriptive?  Thanks.

Sure; they were single-use throwaways to break long RMW lines but I've rejiggled
& removed them.

Thanks for looking, I'll repost v3 with tidyups.


Cheers,


Matt
