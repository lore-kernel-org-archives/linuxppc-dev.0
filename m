Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Fri, 25 Jan 2008 20:20:34 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: Reminder: removal of arch/ppc
Message-ID: <20080125202034.43556262@zod.rchland.ibm.com>
In-Reply-To: <adahch1jruv.fsf@cisco.com>
References: <E83C3B2F-0FC4-4248-B718-0C45B56E969A@kernel.crashing.org>
	<20080125192150.4cde6fac@zod.rchland.ibm.com>
	<adahch1jruv.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Jan 2008 17:30:32 -0800
Roland Dreier <rdreier@cisco.com> wrote:

>  > > 	YUCCA
>  > 
>  > Yucca was what again?  440spe?
> 
> Yes, it was the first 440SPe eval board; since replaced by Katmai.
> 
> I have a Yucca and can at least test thing; if no one else gets to it,
> I may try to port it to arch/powerpc for 2.6.26.

Hm.  Katmai is already in-tree.  Theoretically I should be able to get
the HW docs and do a new DTS and have it mostly "just work".  Perhaps
I'll give that a shot and have you give it a quick spin.

josh
