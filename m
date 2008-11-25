Return-Path: <gerickson@nuovations.com>
Received: from relay00.pair.com (relay00.pair.com [209.68.5.9])
	by ozlabs.org (Postfix) with SMTP id BA33FDDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 06:04:24 +1100 (EST)
Date: Tue, 25 Nov 2008 11:04:15 -0800
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
From: Grant Erickson <gerickson@nuovations.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, Matt Sealey <matt@genesi-usa.com>
Message-ID: <C5518C2F.13137%gerickson@nuovations.com>
In-Reply-To: <20081125135519.038abf23@zod.rchland.ibm.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Wolfgang Denx <wd@denx.de>, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/25/08 10:55 AM, Josh Boyer wrote:
> On Tue, 25 Nov 2008 12:53:12 -0600
> "Matt Sealey" <matt@genesi-usa.com> wrote:
>> Nitpick, really.. shouldn't the logbuffer location(s) be some device tree
>> property(ies), perhaps something in the
>> /chosen node that U-Boot etc. can then fill out?
> 
> I don't think that's a nitpick.  It's a fundamental change in how this
> would all work.  However, I do think you're generally right.
> 
> Perhaps not /chosen, but maybe something like /rtas or /firmware, etc.

I'm inclined to agree with you both; however, the submitted implementation
was a choice of expediency given the existing DENX implementation and a
customer that needed the feature "yesterday".

ARM, MIPS, et al have not yet adopted device trees, correct? If so, is there
value in providing the submitted implementation and adding support for
getting said information from the device tree as another option if such
information exists?

Regards,

Grant
