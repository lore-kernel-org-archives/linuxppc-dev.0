Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id DC10FDDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 00:38:11 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so750948yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jul 2008 07:38:10 -0700 (PDT)
Date: Wed, 9 Jul 2008 08:38:07 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Updates to powerpc.git
Message-ID: <20080709143807.GD26524@secretlab.ca>
References: <1215588881.8970.358.camel@pasglop>
	<20080709091846.69b08e34@zod.rchland.ibm.com>
	<BA91427F-F52C-4AA5-886B-E8D7527EA203@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BA91427F-F52C-4AA5-886B-E8D7527EA203@kernel.crashing.org>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 09, 2008 at 08:40:21AM -0500, Kumar Gala wrote:
>
> On Jul 9, 2008, at 8:18 AM, Josh Boyer wrote:
>
>> On Wed, 09 Jul 2008 17:34:41 +1000
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> Also, Paul is pretty good about not rebasing his branches when at all
>> possible, and I suspect that's why his master and next were often the
>> same.  It makes life lots easier for the sub-maintainers and anyone
>> trying to track against the tree.  I humbly beg you to keep that  
>> going.
>
> I agree and I'm sure linus will tell you how evil it is to rebase as a  
> maintainer.

Add my voice to the chorus.  Rebasing a branch that I commit on top of
really messes up the workflow.

g.
