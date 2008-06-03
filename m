Return-Path: <dgibson@ozlabs.org>
Date: Wed, 4 Jun 2008 08:39:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
Message-ID: <20080603223905.GA22982@yookeroo.seuss>
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>
	<1212130188-28835-2-git-send-email-wg@grandegger.com>
	<20080602020352.GB19393@yookeroo.seuss>
	<479BA7CE-CD12-4935-87EB-E69025D408E6@kernel.crashing.org>
	<4845181E.8040603@grandegger.com>
	<07AEED44-7DEB-46C1-B028-3EFA274CEB11@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <07AEED44-7DEB-46C1-B028-3EFA274CEB11@kernel.crashing.org>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 03, 2008 at 09:33:12AM -0500, Kumar Gala wrote:
> On Jun 3, 2008, at 5:08 AM, Wolfgang Grandegger wrote:
>> Kumar Gala wrote:
>>> On Jun 1, 2008, at 9:03 PM, David Gibson wrote:
>>>> On Fri, May 30, 2008 at 08:49:45AM +0200, Wolfgang Grandegger wrote:
[snip]
>>>> You have a whole lot of 'cell-index' properties through both these
>>>> trees, and they all look wrong.  cell-index is a hack, which  
>>>> should be
>>>> avoided wherever practical - it should only be used when the index  
>>>> is
>>>> used to offset into some global register block, never simply to
>>>> differentiate (use reg for that) or name the devices (use aliases  
>>>> for
>>>> that).
>>>
>>> this is why FSL device tree's have cell-index.  We have global  
>>> control
>>> registers that need to know such things.
>>
>> Should I remove them or not? OF is still a mystery for me :-(.
>
> Don't remove them.

Yes, they're ok, given this usage.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
